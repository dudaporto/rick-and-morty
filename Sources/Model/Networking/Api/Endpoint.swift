//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//
struct Endpoint {
    let path: ApiPath
    let httpMethod: HTTPMethod
    var parameters: [String: Any]?
    
    var fullPath: String { path.fullPath }

    static let character = Endpoint(path: .character, httpMethod: .get)
    static let episose = Endpoint(path: .episode, httpMethod: .get)
    static let location = Endpoint(path: .location, httpMethod: .get)
}
