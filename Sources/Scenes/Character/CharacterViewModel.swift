//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Maria Porto on 27/04/22.
//

import Foundation

protocol CharacterViewModelType: AnyObject {
    func fetchCharacterInfo()
}

final class CharacterViewModel {
    private let coordinator: CharacterCoordinatorType
    private let character: Character
    weak var viewController: CharacterViewControllerType?
    
    init(coordinator: CharacterCoordinatorType, character: Character) {
        self.coordinator = coordinator
        self.character = character
    }
}

extension CharacterViewModel: CharacterViewModelType {
    func fetchCharacterInfo() {
        viewController?.displayCharacterInfo(name: character.name)
        guard let viewController = viewController,
              let url = URL(string: ApiPath.baseUrl + character.image.path) else { return }
        
        ImageService.shared.load(for: viewController, imageUrl: url)
    }
}
