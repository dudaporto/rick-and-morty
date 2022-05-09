enum ApiPath: String {
    static let baseUrl = "https://rickandmortyapi.com/"
    
    case character
    case episode
    case location
    
    var fullPath: String {
        Self.baseUrl + "api/" + rawValue + "/"
    }
}
