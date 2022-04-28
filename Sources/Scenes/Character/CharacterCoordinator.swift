//
//  CharacterCoordinator.swift
//  RickAndMorty
//
//  Created by Maria Porto on 27/04/22.
//

import UIKit

protocol CharacterCoordinatorType: AnyObject {
    var viewController: UIViewController? { get set }
}

final class CharacterCoordinator: CharacterCoordinatorType {
    weak var viewController: UIViewController?
    
    
}
