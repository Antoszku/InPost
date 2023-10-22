import PackService

protocol PackListInteractor {
    func getPacks() async throws -> [PackPresentable]
    func archivePack(_ pack: PackPresentable.ID)
    func getArchivedPackIds() -> Set<PackPresentable.ID>
}

struct DefaultPackListInteractor: PackListInteractor {
    let service: PackService

    func getPacks() async throws -> [PackPresentable] {
        let packs = try await service.getPacks()
        return packs.map(PackPresentable.init)
    }

    func archivePack(_ packId: PackPresentable.ID) {
        service.archivePackId(packId.value)
    }

    func getArchivedPackIds() -> Set<PackPresentable.ID> {
        Set(service.getArchivedPackIds().map(PackPresentable.ID.init))
    }
}
