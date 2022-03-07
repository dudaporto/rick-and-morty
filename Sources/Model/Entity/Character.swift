//
//  Character.swift
//  RickAndMorty
//
//  Created by Maria Porto on 10/12/21.
//

import Foundation

struct Character: Decodable {
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: CharacterGender
    let origin: Location
    let location: Location
    let image: URL
}

@frozen
enum CharacterStatus: String, Decodable {
    case Alive
    case Dead
    case unknown
}

@frozen
enum CharacterGender: String, Decodable {
    case Female
    case Male
    case Genderless
    case unknown
}
