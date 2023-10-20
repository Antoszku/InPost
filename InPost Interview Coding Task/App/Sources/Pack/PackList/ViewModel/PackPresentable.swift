import PackService

struct PackPresentable: Identifiable {
    let id: String
    let packageNumber: String
    let status: String
    let sender: String
}

extension PackPresentable {
    init(dto: PackDTO) {
        id = dto.id
        packageNumber = dto.id
        status = dto.status
        sender = dto.sender
    }
}
