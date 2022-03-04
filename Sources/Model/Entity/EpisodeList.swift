//
//  EpisodeList.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

struct EpisodeList: Decodable {
    let info: PaginationInfo
    let results: [Episode]
}
