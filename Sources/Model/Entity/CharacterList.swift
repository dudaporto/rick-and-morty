//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

struct CharacterList: Decodable {
    let info: PaginationInfo
    let results: [Character]
}
