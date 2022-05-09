import Foundation

protocol CharacterViewModelType: AnyObject {
    func characterInfo(for index: Int) -> CharacterInfoContent?
    func episodeInfo(for index: Int) -> CharacterEpisodeContent? 
    func fetchCharacterInfo()
    func numberOfItens(for section: Int) -> Int
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
    private let service: CharacterServicing
    private let character: Character
    
    private var episodesContent = [CharacterEpisodeContent]()
   
    weak var viewController: CharacterViewControllerType?
    
    init(service: CharacterServicing, character: Character) {
        self.service = service
        self.character = character
    }
}

extension CharacterViewModel: CharacterViewModelType {
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
    
    func episodeInfo(for index: Int) -> CharacterEpisodeContent? {
        guard episodesContent.indices.contains(index) else {
            return nil
        }
        
        return episodesContent[index]
    }
    
    func fetchCharacterInfo() {
        viewController?.displayCharacterHeader(name: character.name,
                                               statusColor: character.status.color,
                                               statusDescription: character.status.descritpion)
        
        guard let viewController = viewController,
              let url = URL(string: ApiPath.baseUrl + character.image.path) else { return }
        
        ImageService.shared.load(for: viewController, imageUrl: url)
        fetchEpisodes()
    }
    
    func numberOfItens(for section: Int) -> Int {
        switch CharacterViewController.Section(rawValue: section) {
        case .about:
            return InfoSection.allCases.count
        case .episodes:
            return episodesContent.count
        case .none:
            return 0
        }
    }
}

private extension CharacterViewModel {
    func fetchEpisodes() {
        let ids = getEpisodesIds()
        guard !ids.isEmpty else { return }
        
        service.getEpisodes(ids: ids) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let episodes):
                self.episodesContent = episodes.enumerated().map { index, ep in
                    CharacterEpisodeContent(episode: ep, hideSeparatorView: index == episodes.count - 1)
                }
                
            case .failure:
                // TODO: Feedback de erro
                break
            }
            
            self.viewController?.displayEpisodes()
        }
    }
    
    func getEpisodesIds() -> [Int] {
        let maxArraySize = min(5, character.episode.count)
        
        return Array(character.episode.compactMap { episode in
            Int(episode.lastPathComponent)
        }[..<maxArraySize])
    }
}
