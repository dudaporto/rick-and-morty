//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Maria Porto on 24/03/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private lazy var characterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Characters", for: [])
        button.addTarget(self, action: #selector(showCharacterList), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(characterButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        characterButton.translatesAutoresizingMaskIntoConstraints = false
        characterButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        characterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        characterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func showCharacterList() {
        let vc = CharacterListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
