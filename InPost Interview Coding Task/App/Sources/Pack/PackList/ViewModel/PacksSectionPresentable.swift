struct PacksSectionPresentable: Identifiable, Equatable {
    let id: String
    let name: String
    let variations: [PackPresentable]

    init(packState: PackState, packs: [PackPresentable]) {
        id = packState.name
        name = packState.name
        variations = packs
    }
}
