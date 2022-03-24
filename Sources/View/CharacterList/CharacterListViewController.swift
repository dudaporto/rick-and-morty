//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Maria Porto on 10/12/21.
//

import UIKit

final class CharacterListViewController: UIViewController {
    private typealias Localizable = Strings.CharacterList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Localizable.title
    }
}

extension CharacterListViewController: ViewSetup {
    func setupConstraints() {
        
    }
    
    func setupHierarchy() {
        
    }
    
    func setupStyles() {
        
    }
}
