@testable import Pack

final class PackListInteractorStub: PackListInteractor {
    var getPacksCalled = false
    var getPacksReturn = [PackPresentable]()

    func getPacks() async throws -> [PackPresentable] {
        getPacksCalled = true
        return getPacksReturn
    }
}
