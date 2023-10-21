enum PackState {
    case inTransit
    case deliveryCompleted

    var name: String {
        switch self {
        case .inTransit: "123"
        case .deliveryCompleted: "123"
        }
    }
}
