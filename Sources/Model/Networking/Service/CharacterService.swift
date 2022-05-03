import Foundation

protocol CharacterServicing: Servicing {
    func getCharacters(filter: CharacterFilter, completion: @escaping NetworkResponse<CharacterList>)
    func getCharacters(by ids: [Int], completion: @escaping NetworkResponse<[Character]>)
}

final class CharacterService: CharacterServicing {    
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
    
    func getCharacters(by ids: [Int], completion: @escaping NetworkResponse<[Character]>) {
        let endpoint = Endpoint(path: .character, filterPath: ids)
        let request = Request<[Character]>(endpoint: endpoint)
        
        request.perform { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    private func generateFilterDictionary(filter: CharacterFilter) -> [String: String] {
        var filters = [String: String]()
        if let name = filter.name { filters[Filter.name.value] = name }
        if let status = filter.status { filters[Filter.status.value] = status.rawValue }
        if let species = filter.species { filters[Filter.species.value] = species }
        if let type = filter.type { filters[Filter.type.value] = type }
        if let gender = filter.gender { filters[Filter.gender.value] = gender.rawValue }
        filters[Filter.page.value] = String(filter.page)
        return filters
    }
    
    private enum Filter: String {
        case name
        case status
        case species
        case type
        case gender
        case page
        
        var value: String { rawValue }
    }
}
