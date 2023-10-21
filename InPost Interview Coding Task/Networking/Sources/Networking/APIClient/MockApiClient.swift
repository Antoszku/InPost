import Foundation

struct MockApiClient: APIClient {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func sendRequest<T>(_: Request) async throws -> T where T: Decodable {
        let url = Bundle.module.url(forResource: "packs", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let result = try! jsonDecoder.decode(T.self, from: data)
        return result
    }
}
