//
//  ApiError.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case serverError
    case decodingError
}
