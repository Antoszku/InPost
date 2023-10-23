import Combine
@testable import Pack
import XCTest

final class PackListViewModelTests: XCTestCase {
    private let earlierDate = Calendar.current.date(from: DateComponents(year: 2021))!
    private let laterDate = Calendar.current.date(from: DateComponents(year: 2023))!

    func testInitialStateIsLoading() {
        XCTAssertEqual(makeSut().state, .loading)
    }

    func testOnAppear_callInteractorGetPacks() async {
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)

        await sut.onAppear()

        XCTAssertTrue(interactor.getPacksCalled)
    }

    func testOnAppear_setStateToData_whenSuccessFromInteractor() async {
        let sut = makeSut()

        await sut.onAppear()

        XCTAssertEqual(sut.state, .data(sections: []))
    }

    func testOnAppear_setStateToDataWithInTransitSection_whenSuccessFromInteractor() async {
        let packs: [PackPresentable] = [.build(id: "1", packState: .inTransit), .build(id: "2", packState: .inTransit)]
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = packs

        await sut.onAppear()

        let section = PacksSectionPresentable(packState: .inTransit, packs: packs)
        XCTAssertEqual(sut.state, .data(sections: [section]))
    }

    func testOnAppear_setStateToDataWithDeliveryCompletedSection_whenSuccessFromInteractor() async {
        let packs: [PackPresentable] = [.build(id: "1", packState: .deliveryCompleted), .build(id: "2", packState: .deliveryCompleted)]
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = packs

        await sut.onAppear()

        let section = PacksSectionPresentable(packState: .deliveryCompleted, packs: packs)
        XCTAssertEqual(sut.state, .data(sections: [section]))
    }

    func testOnAppear_setStateToDataWithDeliveryCompletedAndInTransitSection() async {
        let inTransitPack = PackPresentable.build(id: "1", packState: .inTransit)
        let deliveryCompletedPack = PackPresentable.build(id: "2", packState: .deliveryCompleted)
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = [inTransitPack, deliveryCompletedPack]

        await sut.onAppear()

        let inTransitSection = PacksSectionPresentable(packState: .inTransit, packs: [inTransitPack])
        let deliveryCompletedSection = PacksSectionPresentable(packState: .deliveryCompleted, packs: [deliveryCompletedPack])
        XCTAssertEqual(sut.state, .data(sections: [inTransitSection, deliveryCompletedSection]))
    }

    func testOnPullToRefresh_callInteractorGetPacks() async {
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)

        await sut.onPullToRefresh()

        XCTAssertTrue(interactor.getPacksCalled)
    }

    func testOnPullToRefresh_setStateToDataFromInteractor() async {
        let inTransitPack = PackPresentable.build(id: "1", packState: .inTransit)
        let deliveryCompletedPack = PackPresentable.build(id: "2", packState: .deliveryCompleted)
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = [inTransitPack, deliveryCompletedPack]

        await sut.onPullToRefresh()

        let inTransitSection = PacksSectionPresentable(packState: .inTransit, packs: [inTransitPack])
        let deliveryCompletedSection = PacksSectionPresentable(packState: .deliveryCompleted, packs: [deliveryCompletedPack])
        XCTAssertEqual(sut.state, .data(sections: [inTransitSection, deliveryCompletedSection]))
    }

    func testOnPullToRefresh_setLoadingStateAtTheBeginning() async {
        let sut = makeSut()
        var states = [PackListViewModel.State]()
        var container = [AnyCancellable]()

        sut.$state.sink {
            states.append($0)
        }.store(in: &container)

        await sut.onPullToRefresh()

        XCTAssertEqual(states, [.loading, .loading, .data(sections: [])])
    }

    func test_sortPacksBySortOrderNumber() async {
        let pack1 = PackPresentable.build(sortOrderNumber: 4)
        let pack2 = PackPresentable.build(sortOrderNumber: 2)

        await assertSorting(expectedPacks: [pack1, pack2])
    }

    func test_sortPacksBySortOrderNumber_forInTransitAndDeliveryCompletedPackStates() async {
        let pack1 = PackPresentable.build(packState: .inTransit, sortOrderNumber: 10)
        let pack2 = PackPresentable.build(packState: .inTransit, sortOrderNumber: 20)
        let pack3 = PackPresentable.build(packState: .deliveryCompleted, sortOrderNumber: 10)
        let pack4 = PackPresentable.build(packState: .deliveryCompleted, sortOrderNumber: 20)
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = [pack1, pack2, pack3, pack4]

        await sut.onAppear()

        let expectedInTransitSection = PacksSectionPresentable(packState: .inTransit, packs: [pack2, pack1])
        let expectedInDeliveryCompleted = PacksSectionPresentable(packState: .deliveryCompleted, packs: [pack4, pack3])
        XCTAssertEqual(sut.state, .data(sections: [expectedInTransitSection, expectedInDeliveryCompleted]))
    }

    func test_sortPacksByPickupDate() async {
        // Sort by package that were most recently picked up
        let pack1 = PackPresentable.build(pickupDate: laterDate)
        let pack2 = PackPresentable.build(pickupDate: earlierDate)
        let pack3 = PackPresentable.build(pickupDate: nil)

        await assertSorting(expectedPacks: [pack1, pack2, pack3])
    }

    func test_sortPacksByExpiryDate() async {
        // Sort by package that require faster pick up
        let pack1 = PackPresentable.build(expiryDate: earlierDate)
        let pack2 = PackPresentable.build(expiryDate: laterDate)
        let pack3 = PackPresentable.build(expiryDate: nil)

        await assertSorting(expectedPacks: [pack1, pack2, pack3])
    }

    func test_sortPacksByStoredDate() async {
        // Sort by package that were most recently stored
        let pack1 = PackPresentable.build(storedDate: earlierDate)
        let pack2 = PackPresentable.build(storedDate: laterDate)
        let pack3 = PackPresentable.build(storedDate: nil)

        await assertSorting(expectedPacks: [pack1, pack2, pack3])
    }

    func test_sortPacksById() async {
        // Sort by package id
        let pack1 = PackPresentable.build(id: "1")
        let pack2 = PackPresentable.build(id: "2")

        await assertSorting(expectedPacks: [pack1, pack2])
    }

    func test_sortPacksById_baseOnIntOrder() async {
        // Sort by package id
        let pack1 = PackPresentable.build(id: "2")
        let pack2 = PackPresentable.build(id: "10")

        await assertSorting(expectedPacks: [pack1, pack2])
    }

    func test_sortByPriority_sortOrderNumber_pickupDate_expiryDate_storeDate_id() async {
        let pack1 = PackPresentable.build(id: "9", expiryDate: nil, pickupDate: nil, storedDate: nil, sortOrderNumber: 100)
        let pack2 = PackPresentable.build(id: "8", expiryDate: nil, pickupDate: nil, storedDate: nil, sortOrderNumber: 90)
        let pack3 = PackPresentable.build(id: "7", expiryDate: nil, pickupDate: laterDate, storedDate: nil)
        let pack4 = PackPresentable.build(id: "6", expiryDate: nil, pickupDate: earlierDate, storedDate: nil)
        let pack5 = PackPresentable.build(id: "5", expiryDate: earlierDate, pickupDate: nil, storedDate: nil)
        let pack6 = PackPresentable.build(id: "4", expiryDate: laterDate, pickupDate: nil, storedDate: nil)
        let pack7 = PackPresentable.build(id: "3", expiryDate: nil, pickupDate: nil, storedDate: earlierDate)
        let pack8 = PackPresentable.build(id: "2", expiryDate: nil, pickupDate: nil, storedDate: laterDate)
        let pack9 = PackPresentable.build(id: "100", expiryDate: nil, pickupDate: nil, storedDate: nil)
        let pack10 = PackPresentable.build(id: "200", expiryDate: nil, pickupDate: nil, storedDate: nil)

        await assertSorting(expectedPacks: [pack1,
                                            pack2,
                                            pack3,
                                            pack4,
                                            pack5,
                                            pack6,
                                            pack7,
                                            pack8,
                                            pack9,
                                            pack10])
    }

    func test_onArchivePack_callInteractorArchivedPackId() async {
        let pack = PackPresentable.build(id: "9")
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = [pack]
        await sut.onAppear()

        await sut.onArchivePack(pack)

        XCTAssertEqual(interactor.archivedPackCalledWithPackId, pack.id)
    }

    func test_onArchivePack_removePackFromData() async {
        let packToArchive = PackPresentable.build(id: "1")
        let pack = PackPresentable.build(id: "2")
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = [packToArchive, pack]
        await sut.onAppear()

        await sut.onArchivePack(packToArchive)

        let expectedValue = [PacksSectionPresentable(packState: .inTransit, packs: [pack])]
        XCTAssertEqual(sut.state, .data(sections: expectedValue))
    }

    func test_doNotShowArchivedPacks() async {
        let archivedId = "1"
        let archivedPack = PackPresentable.build(id: archivedId)
        let pack = PackPresentable.build(id: "2")
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = [archivedPack, pack]
        interactor.getArchivedPackIdsReturn = [.init(archivedId)]

        await sut.onAppear()

        XCTAssertEqual(sut.state, .data(sections: [.init(packState: .inTransit, packs: [pack])]))
    }

    func test_isExpandedPackCellReturnTrue() {
        let pack = PackPresentable.build(id: "1")
        let sut = makeSut()

        sut.expandedPackCell = pack

        XCTAssertTrue(sut.isExpandedPackCell(pack))
    }

    func test_isExpandedPackCellReturnFalse() {
        let pack = PackPresentable.build(id: "1")
        let sut = makeSut()

        XCTAssertFalse(sut.isExpandedPackCell(pack))
    }

    func test_expandPackCellIsNil_whenCalledWithSameObject() {
        let pack = PackPresentable.build(id: "1")
        let sut = makeSut()

        sut.expandedPackCell = pack
        sut.expandedPackCell = pack

        XCTAssertNil(sut.expandedPackCell)
    }

    private func assertSorting(expectedPacks: [PackPresentable], line: UInt = #line) async {
        let getPacksReturn: [PackPresentable] = expectedPacks.reversed()
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = getPacksReturn

        await sut.onAppear()

        let expectedSection = PacksSectionPresentable(packState: .inTransit, packs: expectedPacks)
        XCTAssertEqual(sut.state, .data(sections: [expectedSection]), line: line)
    }

    private func makeSut(interactor: PackListInteractor = PackListInteractorStub()) -> PackListViewModel {
        PackListViewModel(interactor: interactor)
    }
}
