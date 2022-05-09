import UIKit

protocol CharacterListCoordinatorType: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToCharacterProfile(with info: Character)
}

final class CharacterListCoordinator: CharacterListCoordinatorType {
    weak var viewController: UIViewController?
    
    func coordinateToCharacterProfile(with info: Character) {
        let service = CharacterService()
        let viewModel = CharacterViewModel(service: service, character: info)
        let newScene = CharacterViewController(viewModel: viewModel)
        viewModel.viewController = newScene
        viewController?.show(newScene, sender: nil)
    }
}
