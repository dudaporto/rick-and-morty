//
//  LocationClient.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

protocol LocationClienting: Clienting {
    func getAllLocations(completion: @escaping NetworkResponse<LocationList>)
    func getLocation(by id: Int, completion: @escaping NetworkResponse<Location>)
    func getLocations(by ids: [Int], completion: @escaping NetworkResponse<[Location]>)
}

final class LocationClient: LocationClienting {
    lazy var shared = LocationClient()
    
    private init() { }
    
    func getAllLocations(completion: @escaping NetworkResponse<LocationList>) {
        
    }
    
    func getLocation(by id: Int, completion: @escaping NetworkResponse<Location>) {
        
    }
    
    func getLocations(by ids: [Int], completion: @escaping NetworkResponse<[Location]>) {
        
    }
}
