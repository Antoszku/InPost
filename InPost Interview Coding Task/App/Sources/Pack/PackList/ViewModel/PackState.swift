enum PackState {
    case inTransit
    case deliveryCompleted

    var sectionName: String {
        switch self {
        case .inTransit: PackListAssets.Texts.inTransitSectionTitle
        case .deliveryCompleted: PackListAssets.Texts.deliveryCompletedSectionTitle
        }
    }
}
