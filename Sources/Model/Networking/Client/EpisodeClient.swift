//
//  EpisodeClient.swift
//  RickAndMorty
//
//  Created by Maria Porto on 04/03/22.
//

protocol EpisodeClienting: Clienting {
    func getAllEpisodes(completion: @escaping NetworkResponse<EpisodeList>)
    func getEpisode(by id: Int, completion: @escaping NetworkResponse<Episode>)
    func getEpisodes(by ids: [Int], completion: @escaping NetworkResponse<[Episode]>)
}

final class EpisodeClient: EpisodeClienting {
    lazy var shared = EpisodeClient()
    
    private init() { }
    
    func getAllEpisodes(completion: @escaping NetworkResponse<EpisodeList>) {
         
    }
    
    func getEpisode(by id: Int, completion: @escaping NetworkResponse<Episode>) {
         
    }
    
    func getEpisodes(by ids: [Int], completion: @escaping NetworkResponse<[Episode]>) {
         
    }
}
