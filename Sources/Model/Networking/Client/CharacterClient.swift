//
//  CharacterClient.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

protocol CharacterClienting: Clienting {
    func getAllCharacters(completion: @escaping NetworkResponse<CharacterList>)
    func getCharacter(by id: Int, completion: @escaping NetworkResponse<Character>)
    func getCharacters(by ids: [Int], completion: @escaping NetworkResponse<[Character]>)
}

final class CharacterClient: CharacterClienting {
    lazy var shared = CharacterClient()
    
    private init() { }
    
    func getAllCharacters(completion: @escaping NetworkResponse<CharacterList>) {
         
    }
    
    func getCharacter(by id: Int, completion: @escaping NetworkResponse<Character>) {
         
    }
    
    func getCharacters(by ids: [Int], completion: @escaping NetworkResponse<[Character]>) {
         
    }
}
