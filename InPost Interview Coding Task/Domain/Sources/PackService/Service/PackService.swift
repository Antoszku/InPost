import DataStorage
import Networking

public protocol PackService {
    func getPacks() async throws -> [PackDTO]
    func archivePackId(_ packId: String)
    func getArchivedPackIds() -> Set<String>
}

struct DefaultPackService: PackService {
    let apiClient: APIClient
    let dataStorage: DataStorage

    func getPacks() async throws -> [PackDTO] {
        let packs: [PackDTO] = try await apiClient.sendRequest(Request(url: "", method: .GET))
        return packs
    }

    func getArchivedPackIds() -> Set<String> {
        dataStorage.getStringSet(forKey: .ArchivedPacks)
    }

    func archivePackId(_ packId: String) {
        dataStorage.addValueToSet(packId, forKey: .ArchivedPacks)
    }
}
