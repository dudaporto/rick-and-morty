import Foundation

protocol CharacterListViewModelType: AnyObject {
    func characterContent(for index: Int) -> CharacterListCellContent?
    func didSelectCharacter(at index: Int)
    func loadContent()
    func didChangeSearchName(name: String)
    func loadImage(for receiver: ImageReceiver, at index: Int)
    func numberOfItens(for section: Int) -> Int
    func getRearchedName() -> String
    func loadMoreCharacters()
}

final class CharacterListViewModel {
    private let coordinator: CharacterListCoordinatorType
    private let service: CharacterServicing
    weak var viewController: CharacterListViewControllerType?
    
    private var filter = CharacterFilter()
    private var shouldDisplaySearchError = false
    private var hasNextPage = true
    private var charactersContents = [CharacterListCellContent]()
    private var characters = [Character]() {
        didSet {
            mapViewModels()
        }
    }
    
    private var filterTimer: Timer?
    
    init(coordinator: CharacterListCoordinatorType, service: CharacterServicing) {
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
    
    func didSelectCharacter(at index: Int) {
        let character = characters[index]
        coordinator.coordinateToCharacterProfile(with: character)
    }
    
    func didChangeSearchName(name: String) {
        filterTimer?.invalidate()
        filterTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.fetchFilteredCharacters(name: name)
        }
    }
    
    func loadContent() {
        clearList()
        viewController?.startLoading()
        fetchCharacters()
    }
    
    func loadImage(for receiver: ImageReceiver, at index: Int) {
        let character = characters[index]
        guard let url = URL(string: ApiPath.baseUrl + character.image.path) else {
            return
        }
        
        ImageService.shared.load(for: receiver, imageUrl: url)
    }
    
    func numberOfItens(for section: Int) -> Int {
        switch CharacterListViewController.Section(rawValue: section) {
        case .characters:
            return charactersContents.count
        case .infoView:
            return shouldDisplaySearchError ? 1 : 0
        case .seeMore:
            return hasNextPage && charactersContents.count > 0 ? 1 : 0
        case .none:
            return 0
        }
    }
    
    func getRearchedName() -> String {
        filter.name ?? ""
    }
    
    func loadMoreCharacters() {
        filter.page += 1
        fetchCharacters()
    }
}

private extension CharacterListViewModel {
    func mapViewModels() {
        charactersContents = characters.map { character in
            CharacterListCellContent(character: character)
        }
    }
    
    func fetchFilteredCharacters(name: String) {
        clearList()
        filter.name = name
        fetchCharacters()
    }
    
    func clearList() {
        clearFilter()
        characters.removeAll()
        shouldDisplaySearchError = false
        viewController?.displayCharacters()
    }
    
    func clearFilter() {
        filter.name = nil
        filter.status = nil
        filter.species = nil
        filter.type = nil
        filter.gender = nil
        filter.page = 1
    }
    
    func fetchCharacters() {
        service.getCharacters(filter: filter) { [weak self] result in
            guard let self = self else { return }
            
            self.viewController?.stopLoading()
            switch result {
            case .success(let list):
                guard !list.results.isEmpty else { fallthrough }
                self.shouldDisplaySearchError = false
                self.hasNextPage = list.info.next != nil
                self.characters.append(contentsOf: list.results)
            case .failure:
                self.shouldDisplaySearchError = true
                self.viewController?.displayError()
               // print("Error: \(error.localizedDescription)")
            }
            
            self.viewController?.displayCharacters()
        }
    }
}


