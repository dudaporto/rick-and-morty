import Foundation

struct Episode: Decodable {
    let name: String
    let airDate: Date
    let episode: String
    let characters: [URL]
}
