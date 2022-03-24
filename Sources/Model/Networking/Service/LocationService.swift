//
//  LocationService.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

protocol LocationServicing: Servicing {
    func getAllLocations(completion: @escaping NetworkResponse<LocationList>)
    func getLocation(by id: Int, completion: @escaping NetworkResponse<Location>)
    func getLocations(by ids: [Int], completion: @escaping NetworkResponse<[Location]>)
}

final class LocationService: LocationServicing {
    func getAllLocations(completion: @escaping NetworkResponse<LocationList>) {
        
    }
    
    func getLocation(by id: Int, completion: @escaping NetworkResponse<Location>) {
        
    }
    
    func getLocations(by ids: [Int], completion: @escaping NetworkResponse<[Location]>) {
        
    }
}
