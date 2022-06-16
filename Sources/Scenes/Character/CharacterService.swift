import Foundation

protocol CharacterServicing: Servicing {
    func getEpisodes(ids: [Int], completion: @escaping NetworkResponse<EpisodeListResponse>)
}

final class CharacterService: CharacterServicing {
    func getEpisodes(ids: [Int], completion: @escaping NetworkResponse<EpisodeListResponse>) {
        let endpoint = Endpoint(path: .episode, filterPath: ids)
        let request = Request<EpisodeListResponse>(endpoint: endpoint)
        
        request.perform { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
