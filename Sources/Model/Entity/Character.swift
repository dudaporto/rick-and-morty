import UIKit

struct Character: Decodable, Equatable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: CharacterGender
    let origin: Location
    let location: Location
    let image: URL
    let episode: [URL]
}

@frozen
enum CharacterStatus: String, Decodable, Equatable {
    case Alive
    case Dead
    case unknown
    
    var descritpion: String {
        rawValue.capitalizingFirstLetter()
    }
}

@frozen
enum CharacterGender: String, Decodable, Equatable {
    case Female
    case Male
    case Genderless
    case unknown
    
    var descritpion: String {
        rawValue.capitalizingFirstLetter()
    }
}

extension CharacterStatus {
    var color: UIColor {
        switch self {
        case .Alive:
            return Palette.green0.color
        case .Dead:
            return Palette.red0.color
        case .unknown:
            return Palette.gray1.color
        }
    }
}
