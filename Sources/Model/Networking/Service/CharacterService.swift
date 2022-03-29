//
//  CharacterClient.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

import Foundation

protocol CharacterServicing: Servicing {
    func getAllCharacters(completion: @escaping NetworkResponse<CharacterList>)
    func getCharacter(by id: Int, completion: @escaping NetworkResponse<Character>)
    func getCharacters(by ids: [Int], completion: @escaping NetworkResponse<[Character]>)
    func getFilteredCharacters(
        name: String?,
        filter: CharacterFilter?,
        completion: @escaping NetworkResponse<CharacterList>
    )
}

final class CharacterService: CharacterServicing {    
    func getAllCharacters(completion: @escaping NetworkResponse<CharacterList>) {
        let endpoint = Endpoint(path: .character)
        let request = Request<CharacterList>(endpoint: endpoint)
        
        request.perform { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getCharacter(by id: Int, completion: @escaping NetworkResponse<Character>) {
        let endpoint = Endpoint(path: .character, filterPath: [id])
        let request = Request<Character>(endpoint: endpoint)
        
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
    
    func getFilteredCharacters(
        name: String?,
        filter: CharacterFilter?,
        completion: @escaping NetworkResponse<CharacterList>
    ) {
        let parameters = generateFilterDictionary(name: name,
                                                  status: filter?.status,
                                                  species: filter?.species,
                                                  type: filter?.type,
                                                  gender: filter?.gender)
        let endpoint = Endpoint(path: .character, parameters: parameters)
        let request = Request<CharacterList>(endpoint: endpoint)
        
        request.perform { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private func generateFilterDictionary(
        name: String? = nil,
        status: CharacterStatus? = nil,
        species: String? = nil,
        type: String? = nil,
        gender: CharacterGender? = nil
    ) -> [String: String] {
        var filters = [String: String]()
        if let name = name { filters[Filter.name.value] = name }
        if let status = status { filters[Filter.status.value] = status.rawValue }
        if let species = species { filters[Filter.species.value] = species }
        if let type = type { filters[Filter.type.value] = type }
        if let gender = gender { filters[Filter.gender.value] = gender.rawValue }
        return filters
    }
    
    private enum Filter: String {
        case name
        case status
        case species
        case type
        case gender
        
        var value: String { rawValue }
    }
}
