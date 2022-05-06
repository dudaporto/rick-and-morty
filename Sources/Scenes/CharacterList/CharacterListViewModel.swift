import Foundation

protocol CharacterListViewModelType: AnyObject {
    func characterContent(for index: Int) -> CharacterListCellContent?
    func didChangeSearchName(name: String)
    func didSelectCharacter(at index: Int)
    func getErrorContent() -> (title: String, subtitle: String)
    func loadContent(characterName: String?)
    func loadImage(for receiver: ImageReceiver, at index: Int)
    func loadMoreCharacters()
    func numberOfItens(for section: Int) -> Int
}

final class CharacterListViewModel {
    private typealias Localizable = Strings.CharacterList
    
    private let coordinator: CharacterListCoordinatorType
    private let service: CharacterListServicing
    weak var viewController: CharacterListViewControllerType?
    
    private(set) var filter = CharacterFilter()
    private var filterTimer: Timer?
    private var hasNextPage = true
    private var shouldDisplayError = false
   
    private var charactersContents = [CharacterListCellContent]()
    private var characters = [Character]() {
        didSet {
            mapViewModels()
        }
    }
    
    init(coordinator: CharacterListCoordinatorType, service: CharacterListServicing) {
        self.coordinator = coordinator
        self.service = service
    }
}

extension CharacterListViewModel: CharacterListViewModelType {
    func characterContent(for index: Int) -> CharacterListCellContent? {
        guard charactersContents.indices.contains(index) else {
            return nil
        }
        
        return charactersContents[index]
    }
    
    func didChangeSearchName(name: String) {
        filterTimer?.invalidate()
        filterTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.loadContent(characterName: name)
        }
    }
    
    func didSelectCharacter(at index: Int) {
        let character = characters[index]
        coordinator.coordinateToCharacterProfile(with: character)
    }
    
    func getErrorContent() -> (title: String, subtitle: String) {
        guard let searchedName = filter.name else {
            return (GlobalLocalizable.GenericError.title, GlobalLocalizable.GenericError.message)
        }
        
        return (Localizable.NotFound.searchErrorTitle(searchedName), Localizable.NotFound.searchErrorSubtitle)
    }
    
    func loadContent(characterName: String?) {
        clearList()
        viewController?.startLoading()
        filter.name = characterName
        fetchCharacters()
    }
    
    func loadImage(for receiver: ImageReceiver, at index: Int) {
        let character = characters[index]
        guard let url = URL(string: ApiPath.baseUrl + character.image.path) else {
            return
        }
        
        ImageService.shared.load(for: receiver, imageUrl: url)
    }
    
    func loadMoreCharacters() {
        filter.page += 1
        fetchCharacters(isLoadingMorePages: true)
    }
    
    func numberOfItens(for section: Int) -> Int {
        switch CharacterListViewController.Section(rawValue: section) {
        case .characters:
            return charactersContents.count
        case .infoView:
            return shouldDisplayError ? 1 : 0
        case .seeMore:
            return hasNextPage && charactersContents.count > 0 ? 1 : 0
        case .none:
            return 0
        }
    }
}

private extension CharacterListViewModel {
    func clearFilter() {
        filter.name = nil
        filter.page = 1
    }
    
    func clearList() {
        clearFilter()
        characters.removeAll()
        shouldDisplayError = false
        viewController?.displayCharacters()
    }
    
    func fetchCharacters(isLoadingMorePages: Bool = false) {
        service.getCharacters(filter: filter) { [weak self] result in
            guard let self = self else { return }
            
            self.viewController?.stopLoading()
            switch result {
            case .success(let list):
                guard !list.results.isEmpty else { fallthrough }
                self.shouldDisplayError = false
                self.hasNextPage = list.info.next != nil
                self.characters.append(contentsOf: list.results)
            case .failure:
                if isLoadingMorePages {
                    self.filter.page -= 1
                    // show error snack bar
                } else {
                    self.shouldDisplayError = true
                }
            }
            
            self.viewController?.displayCharacters()
        }
    }
    
    func mapViewModels() {
        charactersContents = characters.map { character in
            CharacterListCellContent(character: character)
        }
    }
}


