//
//  Episode.swift
//  RickAndMorty
//
//  Created by Maria Porto on 10/12/21.
//

import Foundation

struct Episode: Decodable {
    let name: String
    let airDate: Date
    let episode: String
    let characters: [URL]
}
