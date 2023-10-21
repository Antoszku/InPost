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

        XCTAssertEqual(sut.state, .data(packs: []))
    }

    func testOnAppear_setStateToDataWithCorrectPacks_whenSuccessFromInteractor() async {
        let packs: [PackPresentable] = [.build(id: "1"), .build(id: "2")]
        let interactor = PackListInteractorStub()
        let sut = makeSut(interactor: interactor)
        interactor.getPacksReturn = packs

        await sut.onAppear()

        XCTAssertEqual(sut.state, .data(packs: packs))
    }

    private func makeSut(interactor: PackListInteractor = PackListInteractorStub()) -> PackListViewModel {
        PackListViewModel(interactor: interactor)
    }
}
