import UIKit

protocol CharacterCoordinatorType: AnyObject {
    var viewController: UIViewController? { get set }
}

final class CharacterCoordinator: CharacterCoordinatorType {
    weak var viewController: UIViewController?
    
    
}
