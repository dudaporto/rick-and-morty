//
//  Servicing.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

protocol Servicing: AnyObject {
    typealias NetworkResponse<T: Decodable> = (Result<T, ApiError>) -> Void
}
