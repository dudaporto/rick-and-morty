@testable import RickAndMorty
import XCTest

private final class CharacterViewControllerTypeSpy: CharacterViewControllerType {
    var currentDownloadTask: Cancellable?
    
    private(set) var callDisplayCharacterHeaderCount = 0
    private(set) var callDisplayEpisodesCount = 0
    private(set) var callSetImageCount = 0
    
    private(set) var calledName: String?
    private(set) var calledStatusColor: UIColor?
    private(set) var calledStatusDescription: String?

    func displayCharacterHeader(name: String, statusColor: UIColor, statusDescription: String) {
        callDisplayCharacterHeaderCount += 1
        calledName = name
        calledStatusColor = statusColor
        calledStatusDescription = statusDescription
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
        let viewModel = CharacterViewModel(service: serviceMock,
                                           character: .mock)
        viewModel.viewController = viewControllerSpy
        return viewModel
    }()
    
    func testfetchCharacterInfo_WhenCalledFromViewController_ShouldDisplayHeaderAndEpisodes() {
        serviceMock.episodesExpectedResult = .success([.mock, .mock2])
        sut.fetchCharacterInfo()
        
        XCTAssertEqual(viewControllerSpy.callDisplayCharacterHeaderCount, 1)
        XCTAssertEqual(viewControllerSpy.callDisplayEpisodesCount, 1)
        XCTAssertEqual(viewControllerSpy.calledName, Character.mock.name)
        XCTAssertEqual(viewControllerSpy.calledStatusColor, Character.mock.status.color)
        XCTAssertEqual(viewControllerSpy.calledStatusDescription, Character.mock.status.descritpion)
    }
    
    func testNumberOfItens_WhenItsAboutSection_ShouldReturnInfoSectionCount() {
        let numberOfItens = sut.numberOfItens(for: 0)
        
        XCTAssertEqual(numberOfItens, InfoSection.allCases.count)
    }
    
    func testNumberOfItens_WhenItsEpisodesSection_ShouldReturnEpisodesCount() {
        let mock: [Episode] = [.mock, .mock2]
        serviceMock.episodesExpectedResult = .success(mock)
        sut.fetchCharacterInfo()
        let numberOfItens = sut.numberOfItens(for: 1)
        
        XCTAssertEqual(numberOfItens, mock.count)
    }
    
    func testNumberOfItens_WhenItsInvalidSection_ShouldReturnZero() {
        let numberOfItens = sut.numberOfItens(for: 2)
        
        XCTAssertEqual(numberOfItens, 0)
    }
}
