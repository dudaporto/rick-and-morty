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
        navigationController?.navigationBar.tintColor = Palette.green1.color
        characterButton.translatesAutoresizingMaskIntoConstraints = false
        characterButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        characterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        characterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private let viewModel: HomeViewModelType
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showCharacterList() {
        viewModel.goToCharacterList()
    }
}
