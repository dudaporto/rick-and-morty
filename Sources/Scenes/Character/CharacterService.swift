import Foundation

protocol CharacterServicing: Servicing {
    func getEpisodes(ids: [Int], completion: @escaping NetworkResponse<[Episode]>)
}

final class CharacterService: CharacterServicing {
    func getEpisodes(ids: [Int], completion: @escaping NetworkResponse<[Episode]>) {
        let endpoint = Endpoint(path: .episode, filterPath: ids)
        let request = Request<[Episode]>(endpoint: endpoint)
        
        request.perform { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
