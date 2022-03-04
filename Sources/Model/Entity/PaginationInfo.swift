//
//  PaginationInfo.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

import Foundation

struct PaginationInfo: Decodable {
    let count: Int
    let pages: Int
    let next: URL?
    let previous: URL?
}
