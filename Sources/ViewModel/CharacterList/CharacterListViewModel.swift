import Foundation

protocol CharacterListViewModelType: AnyObject {
    func characterContent(for index: Int) -> CharacterListCellContent?
    func didSelectCharacter(at index: Int)
    func fetchCharacters()
    func filterCharacters(name: String)
    func loadImage(for receiver: ImageReceiver, at index: Int)
    func numberOfItens() -> Int
}

final class CharacterListViewModel {
    private let service: CharacterServicing
    private let imageService = ImageService()
    weak var viewController: CharacterListViewControllerType?
    
    private var charactersContents = [CharacterListCellContent]()
    private var characterList: CharacterList? {
        didSet {
            mapViewModels()
        }
    }
    
    private var filterTimer: Timer?
    
    init(service: CharacterServicing) {
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
        print("Open character \(index)")
    }
    
    func filterCharacters(name: String) {
        filterTimer?.invalidate()
        filterTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.fetchFilteredCharacters(name: name)
        }
    }
    
    func fetchCharacters() {
        clearList()
        
        viewController?.startLoading()
        service.getAllCharacters { [weak self] result in
            guard let self = self else { return }
            
            self.viewController?.stopLoading()
            switch result {
            case .success(let list):
                self.characterList = list
                self.viewController?.displayCharacters()
            case .failure(let error):
                self.viewController?.displayError()
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func loadImage(for receiver: ImageReceiver, at index: Int) {
        guard characterList?.results.indices.contains(index) ?? false,
              let character = characterList?.results[index],
              let url = URL(string: ApiPath.baseUrl + character.image.path) else {
            return
        }
        
        imageService.load(for: receiver, imageUrl: url)
    }
    
    func numberOfItens() -> Int {
        charactersContents.count
    }
}

private extension CharacterListViewModel {
    func mapViewModels() {
        charactersContents = characterList?.results.map { character in
            CharacterListCellContent(character: character)
        } ?? []
    }
    
    func fetchFilteredCharacters(name: String) {
        clearList()
        print("searching: \(name)")
        viewController?.startLoading()
        service.getFilteredCharacters(name: name, filter: nil) { [weak self] result in
            guard let self = self else { return }
            
            self.viewController?.stopLoading()
            switch result {
            case .success(let list):
                self.characterList = list
                self.viewController?.displayCharacters()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func clearList() {
        characterList = nil
        viewController?.displayCharacters()
    }
}


