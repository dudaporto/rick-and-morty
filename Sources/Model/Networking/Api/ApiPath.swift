//
//  ApiPath.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

enum ApiPath: String {
    private static let baseUrl = "https://rickandmortyapi.com/api/"
    
    case character
    case episode
    case location
    
    var fullPath: String {
        Self.baseUrl + rawValue + "/"
    }
}
