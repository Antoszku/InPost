struct PacksSectionPresentable: Identifiable, Equatable {
    let id: String
    let name: String
    let variations: [PackPresentable]

    init(packState: PackState, packs: [PackPresentable]) {
        id = packState.sectionName
        name = packState.sectionName
        variations = packs
    }
}
