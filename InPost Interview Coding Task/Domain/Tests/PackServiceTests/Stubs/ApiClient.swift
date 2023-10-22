import Foundation
@testable import Networking

struct APIClientStub: APIClient {
    func sendRequest<T: Decodable>(_: Request) async throws -> T {
        throw NSError(domain: "", code: 0)
    }
}
