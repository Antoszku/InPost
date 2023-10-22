@testable import Pack

final class PackListInteractorStub: PackListInteractor {
    var getPacksCalled = false
    var getPacksReturn = [PackPresentable]()

    var archivedPackCalledWithPackId: PackPresentable.ID?

    var getArchivedPackIdsReturn = Set<PackPresentable.ID>()

    func getPacks() async throws -> [PackPresentable] {
        getPacksCalled = true
        return getPacksReturn
    }

    func archivePack(_ pack: PackPresentable.ID) {
        archivedPackCalledWithPackId = pack
    }

    func getArchivedPackIds() -> Set<PackPresentable.ID> {
        getArchivedPackIdsReturn
    }
}
