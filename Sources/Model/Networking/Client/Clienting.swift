//
//  Clienting.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

protocol Clienting: AnyObject {
    typealias NetworkResponse<T: Decodable> = (Result<T, ApiError>) -> Void
    static var shared: Self { get }
}
