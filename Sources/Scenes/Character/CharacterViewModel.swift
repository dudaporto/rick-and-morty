import Foundation

protocol CharacterViewModelType: AnyObject {
    func fetchCharacterInfo()
    func numberOfItens(for section: Int) -> Int
    func characterInfo(for index: Int) -> CharacterInfoContent?
}

private enum InfoSection: String, CaseIterable {
    case specie
    case origin
    case location
    
    var icon: ImageAsset {
        switch self {
        case .specie:
            return Images.iconSpecie
        case .origin:
            return Images.iconOrigin
        case .location:
            return Images.iconLocation
        }
    }
    
    var title: String {
        rawValue.capitalizingFirstLetter() + ":"
    }
}

final class CharacterViewModel {
    private let coordinator: CharacterCoordinatorType
    private let character: Character
    weak var viewController: CharacterViewControllerType?
    
    init(coordinator: CharacterCoordinatorType, character: Character) {
        self.coordinator = coordinator
        self.character = character
    }
}

extension CharacterViewModel: CharacterViewModelType {
    func fetchCharacterInfo() {
        viewController?.displayCharacterHeader(name: character.name,
                                               statusColor: character.status.color,
                                               statusDescription: character.status.descritpion)
        
        guard let viewController = viewController,
              let url = URL(string: ApiPath.baseUrl + character.image.path) else { return }
        
        ImageService.shared.load(for: viewController, imageUrl: url)
    }
    
    func numberOfItens(for section: Int) -> Int {
        switch CharacterViewController.Section(rawValue: section) {
        case .about:
            return InfoSection.allCases.count
        case .episodes:
            return 0
        case .none:
            return 0
        }
    }
    
    func characterInfo(for index: Int) -> CharacterInfoContent? {
        guard InfoSection.allCases.indices.contains(index) else {
            return nil
        }
        
        let section = InfoSection.allCases[index]
        let hideSeparatorView = index == InfoSection.allCases.count - 1
        let description: String
        switch section {
        case .specie:
            description = character.species.capitalizingFirstLetter()
        case .location:
            description = character.location.name.capitalizingFirstLetter()
        case .origin:
            description = character.origin.name.capitalizingFirstLetter()
        }
        
        return CharacterInfoContent(icon: section.icon.image,
                                    title: section.title,
                                    descrition: description,
                                    hideSeparatorView: hideSeparatorView)
    }
}
