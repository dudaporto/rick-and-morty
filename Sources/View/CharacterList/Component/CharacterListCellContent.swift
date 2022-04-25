import UIKit

final class CharacterListCellContent {
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    var name: String {
        character.name
    }

    var statusColor: UIColor {
        character.status.color
    }

    var statusDescription: String {
        character.status.rawValue.capitalizingFirstLetter()
    }
     
    var locationDescription: String {
        character.location.name
    }
}
