import Foundation
protocol CharacterListViewModelType: AnyObject {
    func characterViewModel(for index: Int) -> CharacterListCellViewModel?
    func didSelectCharacter(at index: Int)
    func fetchCharacters()
    func filterCharacters(name: String)
    func numberOfItens() -> Int
}

final class CharacterListViewModel {
    private let service: CharacterServicing
    weak var viewController: CharacterListViewControllerType?
    
    private var charactersViewModels = [CharacterListCellViewModel]()
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
    func characterViewModel(for index: Int) -> CharacterListCellViewModel? {
        guard charactersViewModels.indices.contains(index) else {
            return nil
        }
        
        return charactersViewModels[index]
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
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfItens() -> Int {
        charactersViewModels.count
    }
}

private extension CharacterListViewModel {
    func mapViewModels() {
        charactersViewModels = characterList?.results.map { character in
            CharacterListCellViewModel(
                name: character.name,
                imageUrl: character.image,
                statusColor: character.status.color,
                statusDescription: character.status.rawValue.capitalizingFirstLetter(),
                locationDescription: character.location.name
            )
        } ?? []
    }
    
    func fetchFilteredCharacters(name: String) {
        clearList()
        
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


