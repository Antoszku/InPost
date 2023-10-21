struct DefaultApiClient: APIClient {
    func sendRequest<T>(_: Request) async throws -> T where T: Decodable {
        fatalError("TODO: Implement real APIClient")
    }
}
