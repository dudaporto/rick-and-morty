import UIKit

protocol HomeCoordinatorType: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToCharacterList()
}

final class HomeCoordinator: HomeCoordinatorType {
    var viewController: UIViewController?
    
    func coordinateToCharacterList() {
        let coordinator = CharacterListCoordinator()
        let service = CharacterService()
        let viewModel = CharacterListViewModel(coordinator: coordinator, service: service)
        let vc = CharacterListViewController(viewModel: viewModel)
        
        viewModel.viewController = vc
        coordinator.viewController = vc
        
        viewController?.show(vc, sender: nil)
    }
}
