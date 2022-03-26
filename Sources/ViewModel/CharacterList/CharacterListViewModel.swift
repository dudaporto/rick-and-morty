protocol CharacterListViewModelType: AnyObject {
    func characterViewModel(for index: Int) -> CharacterListCellViewModel?
    func didSelectCharacter(at index: Int)
    func fetchCharacters()
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
    
    func fetchCharacters() {
        service.getAllCharacters { [weak self] result in
            guard let self = self else { return }
            
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
                statusColor: character.status.color,
                statusDescription: character.status.rawValue.capitalizingFirstLetter(),
                locationDescription: character.location.name
            )
        } ?? []
    }
}


