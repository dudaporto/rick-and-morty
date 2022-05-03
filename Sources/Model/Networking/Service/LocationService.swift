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
