import InPostAppKit

struct PacksSectionPresentable: Identifiable, Equatable {
    typealias ID = Identifier<PacksSectionPresentable>

    let id: ID
    let name: String
    let variations: [PackPresentable]

    init(packState: PackState, packs: [PackPresentable]) {
        id = ID(packState.sectionName)
        name = packState.sectionName
        variations = packs
    }
}
