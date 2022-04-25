//
//  ApiPath.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

enum ApiPath: String {
    static let baseUrl = "http://192.168.0.114:3005/"
   // private static let baseUrl = "https://rickandmortyapi.com/"
    
    case character
    case episode
    case location
    
    var fullPath: String {
        Self.baseUrl + "api/" + rawValue + "/"
    }
}
