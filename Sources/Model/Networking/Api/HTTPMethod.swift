//
//  HTTPMethod.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

enum HTTPMethod: String {
    case get
    
    var value: String {
        rawValue.uppercased()
    }
}
