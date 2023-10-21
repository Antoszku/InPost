public protocol APIClient {
    func sendRequest<T: Decodable>(_ request: Request) async throws -> T
}
