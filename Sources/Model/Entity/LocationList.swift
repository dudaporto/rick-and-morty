//
//  LocationList.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

struct LocationList: Decodable {
    let info: PaginationInfo
    let results: [Location]
}
