@testable import RickAndMorty
import Foundation

extension Character {
    static let mock = Character(id: 1,
                                name: "Rick",
                                status: .Alive,
                                species: "Human",
                                gender: .Male,
                                origin: Location(name: "Earth"),
                                location: Location(name: "Earth"),
                                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                                episode: [
                                    URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                                    URL(string: "https://rickandmortyapi.com/api/episode/2")!
                                ])
}
