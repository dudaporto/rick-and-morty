//
//  Location.swift
//  RickAndMorty
//
//  Created by Maria Porto on 10/12/21.
//

import Foundation

struct Location: Decodable {
    let name: String
    let type: String
    let dimension: String
    let residents: [URL]
}
