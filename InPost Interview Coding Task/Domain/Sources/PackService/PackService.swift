import Networking

public protocol PackService {
    func getPacks() async throws -> [PackDTO]
}

struct DefaultPackService: PackService {
    let apiClient: APIClient

    func getPacks() async throws -> [PackDTO] {
        let packs: [PackDTO] = try await apiClient.sendRequest(Request(url: "", method: .GET))
        return packs
    }
}
