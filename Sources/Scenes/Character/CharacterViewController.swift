//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Maria Porto on 25/04/22.
//

import UIKit

protocol CharacterViewControllerType: ImageReceiver {
    func displayCharacterInfo(name: String)
}

final class CharacterViewController: UIViewController {
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var characterTitle: UILabel = {
        let name = UILabel()
        name.text = "Name Example"
        name.font = Typography.largeTitle
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.background.color
        view.border(radius: Radius.medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var topBarHeight: CGFloat {
        navigationController?.navigationBar.frame.height ?? 0 + view.safeAreaInsets.top
    }
    
    private let viewModel: CharacterViewModelType
    var currentDownloadTask: Cancellable?
    
    init(viewModel: CharacterViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        viewModel.fetchCharacterInfo()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStyles()
    }
    
    private func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.black.withAlphaComponent(0.7).cgColor,
                           UIColor.black.withAlphaComponent(0.4).cgColor,
                           UIColor.clear.cgColor]
        gradient.locations = [0, 0.25, 1]
        
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
}

extension CharacterViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: view.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterImage.widthAnchor.constraint(equalTo: characterImage.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            characterInfoContainer.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: -Spacing.space5),
            characterInfoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterInfoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterInfoContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            characterTitle.leadingAnchor.constraint(equalTo: characterInfoContainer.leadingAnchor, constant: Spacing.space3),
            characterTitle.topAnchor.constraint(equalTo: characterInfoContainer.topAnchor, constant: Spacing.space3),
            characterTitle.trailingAnchor.constraint(equalTo: characterInfoContainer.trailingAnchor, constant: -Spacing.space3)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: topBarHeight)
        ])
    }
    
    func setupHierarchy() {
        view.addSubviews(characterImage, characterInfoContainer, gradientView)
        characterInfoContainer.addSubviews(characterTitle)
    }
    
    func setupStyles() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
}

extension CharacterViewController: CharacterViewControllerType {
    func displayCharacterInfo(name: String) {
        characterTitle.text = name
    }
}

extension CharacterViewController {
    func setImage(_ image: UIImage) {
        characterImage.image = image
    }
}
