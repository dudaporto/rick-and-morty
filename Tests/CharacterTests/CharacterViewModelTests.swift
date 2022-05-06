@testable import RickAndMorty
import XCTest

private final class CharacterViewControllerTypeSpy: CharacterViewControllerType {
    var currentDownloadTask: Cancellable?
    
    private(set) var callDisplayCharacterHeaderCount = 0
    private(set) var callDisplayEpisodesCount = 0
    private(set) var callSetImageCount = 0

    func displayCharacterHeader(name: String, statusColor: UIColor, statusDescription: String) {
        callDisplayCharacterHeaderCount += 1
    }

    func displayEpisodes() {
        callDisplayEpisodesCount += 1
    }
    
    func setImage(_ image: UIImage) {
        callSetImageCount += 1
    }
}

private final class CharacterServiceMock: CharacterServicing {
    private(set) var calledIds: [Int]?
    var episodesExpectedResult: Result<[Episode], ApiError>?
    
    func getEpisodes(ids: [Int], completion: @escaping NetworkResponse<[Episode]>) {
        calledIds = ids
        guard let expectedResult = episodesExpectedResult else { return }
        completion(expectedResult)
    }
}

final class CharacterViewModelTests: XCTestCase {
    private let serviceMock = CharacterServiceMock()
    private let viewControllerSpy = CharacterViewControllerTypeSpy()
    
    private lazy var sut: CharacterViewModel = {
        let viewModel = CharacterViewModel(coordinator: CharacterCoordinator(),
                                           service: serviceMock,
                                           character: .mock)
        viewModel.viewController = viewControllerSpy
        return viewModel
    }()
}
