//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

import Foundation

struct Endpoint {
    let path: ApiPath
    let filterPath: [Int]?
    let parameters: [String: String]?
    
    init(path: ApiPath, filterPath: [Int]? = nil, parameters: [String: String]? = nil) {
        self.path = path
        self.filterPath = filterPath
        self.parameters = parameters
    }
    
    var url: URL? {
        guard var urlComponents = URLComponents(string: path.fullPath) else {
            return nil
        }
        
        if let formattedFilterPath = formattedFilterPath {
            urlComponents.path.append(formattedFilterPath)
        }
        
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private var formattedFilterPath: String? {
        var formattedFilterPath = ""
        filterPath?.forEach { element in
            if !formattedFilterPath.isEmpty {
                formattedFilterPath += ","
            }
            
            formattedFilterPath += "\(element)"
        }
        return formattedFilterPath
    }
    
    private var queryItems: [URLQueryItem]? {
        var queryItems = [URLQueryItem]()
        parameters?.forEach { key, value in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        return queryItems
    }
}
