import Combine
@testable import Pack
import XCTest

final class PackListViewModelTests: XCTestCase {
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
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)

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

    private func makeSut(interactor: PackListInteractor = PackListInteractorStub()) -> PackListViewModel {
        PackListViewModel(interactor: interactor)
    }
}
