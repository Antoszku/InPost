public struct Request {
    public enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }

    let url: String
    let method: HTTPMethod

    public init(url: String,
                method: HTTPMethod) {
        self.url = url
        self.method = method
    }
}
