import Foundation

protocol CharacterListServicing: Servicing {
    func getCharacters(filter: CharacterFilter, completion: @escaping NetworkResponse<CharacterList>)
}

final class CharacterListService: CharacterListServicing {
    func getCharacters(
        filter: CharacterFilter,
        completion: @escaping NetworkResponse<CharacterList>
    ) {
        let parameters = generateFilterDictionary(filter: filter)
        let endpoint = Endpoint(path: .character, parameters: parameters)
        let request = Request<CharacterList>(endpoint: endpoint)
        
        request.perform { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    private func generateFilterDictionary(filter: CharacterFilter) -> [String: String] {
        var filters = [String: String]()
        if let name = filter.name { filters[Filter.name.value] = name }
        filters[Filter.page.value] = String(filter.page)
        return filters
    }
    
    private enum Filter: String {
        case name
        case page
        
        var value: String { rawValue }
    }
}
