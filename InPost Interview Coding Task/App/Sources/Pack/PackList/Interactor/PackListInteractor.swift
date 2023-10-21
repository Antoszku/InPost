import PackService

protocol PackListInteractor {
    func getPacks() async throws -> [PackPresentable]
}

struct DefaultPackListInteractor: PackListInteractor {
    let service: PackService

    func getPacks() async throws -> [PackPresentable] {
        let packs = try await service.getPacks()
        return packs.map(PackPresentable.init)
    }
}
