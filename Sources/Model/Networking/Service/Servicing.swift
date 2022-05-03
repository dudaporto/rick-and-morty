protocol Servicing: AnyObject {
    typealias NetworkResponse<T: Decodable> = (Result<T, ApiError>) -> Void
}
