//
//  EpisodeClient.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

protocol EpisodeServicing: Servicing {
    func getAllEpisodes(completion: @escaping NetworkResponse<EpisodeList>)
    func getEpisode(by id: Int, completion: @escaping NetworkResponse<Episode>)
    func getEpisodes(by ids: [Int], completion: @escaping NetworkResponse<[Episode]>)
}

final class EpisodeService: EpisodeServicing {    
    func getAllEpisodes(completion: @escaping NetworkResponse<EpisodeList>) {
         
    }
    
    func getEpisode(by id: Int, completion: @escaping NetworkResponse<Episode>) {
         
    }
    
    func getEpisodes(by ids: [Int], completion: @escaping NetworkResponse<[Episode]>) {
         
    }
}
