//
//  Character.swift
//  RickAndMorty
//
//  Created by Maria Porto on 10/12/21.
//

import Foundation

@frozen
public struct Character: Decodable {
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: CharacterGender
    let origin: Location
    let location: Location
    let image: URL
}

public enum CharacterStatus: String, Decodable {
    case alive
    case dead
    case unknown
}

public enum CharacterGender: String, Decodable {
    case female
    case male
    case genderless
    case unknown
}
