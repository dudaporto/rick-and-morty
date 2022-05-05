@testable import RickAndMorty
import XCTest

// MARK: - CharacterListCoordinatorSpy
private final class  CharacterListCoordinatorSpy: CharacterListCoordinatorType {
    private(set) var callCoordinateToCharacterProfileCount = 0
    
    private(set) var character: Character?
    
    var viewController: UIViewController?
    
    func coordinateToCharacterProfile(with info: Character) {
        callCoordinateToCharacterProfileCount += 1
        character = info
    }
}

// MARK: - CharacterListServiceMock
private final class CharacterListServiceMock: CharacterListServicing {
    private(set) var callGetCharactersCount = 0
    var charactersExpectedResult: Result<CharacterList, ApiError>?
    
    func getCharacters(filter: CharacterFilter, completion: @escaping NetworkResponse<CharacterList>) {
        callGetCharactersCount += 1
        
        guard let expectedResult = charactersExpectedResult else { return }
        completion(expectedResult)
    }
}

// MARK: - CharacterListViewControllerSpy
private final class CharacterListViewControllerSpy: CharacterListViewControllerType {
    private(set) var callDisplayCharactersCount = 0
    private(set) var callStartLoadingCount = 0
    private(set) var callStopLoadingCount = 0
    private(set) var callDidTapTryAgainButtonCount = 0
    
    func displayCharacters() {
        callDisplayCharactersCount += 1
    }

    func startLoading() {
        callStartLoadingCount += 1
    }
    
    func stopLoading() {
        callStopLoadingCount += 1
    }
    
    func didTapTryAgainButton() {
        callDidTapTryAgainButtonCount += 1
    }
}

// MARK: - CharacterListViewModelTests
final class CharacterListViewModelTests: XCTestCase {
    private typealias Localizable = Strings.CharacterList
    private let serviceMock = CharacterListServiceMock()
    private let coordinatorSpy = CharacterListCoordinatorSpy()
    private let viewControllerSpy = CharacterListViewControllerSpy()
    
    private lazy var sut: CharacterListViewModel = {
        let viewModel = CharacterListViewModel(coordinator: coordinatorSpy, service: serviceMock)
        viewModel.viewController = viewControllerSpy
        return viewModel
    }()
    
//    protocol CharacterListViewModelType: AnyObject {
//        func characterContent(for index: Int) -> CharacterListCellContent?
//        func didChangeSearchName(name: String)
//        func didSelectCharacter(at index: Int)
//        func getErrorContent() -> (title: String, subtitle: String)
//        func loadContent(characterName: String?)
//        func loadImage(for receiver: ImageReceiver, at index: Int)
//        func loadMoreCharacters()
//        func numberOfItens(for section: Int) -> Int
//    }
    
    // MARK: characterContent
    
    func testCharacterContent_WhenHasCharacter_ShouldReturnCharacterListCellContent() {
        let index = 1
        let characterList = CharacterList.mock(hasNextPage: true)
        let expectedResult = CharacterListCellContent(character: characterList.results[index])
        
        serviceMock.charactersExpectedResult = .success(characterList)
        sut.loadContent(characterName: nil)
        
        let characterContent = sut.characterContent(for: index)
        
        XCTAssertEqual(characterContent, expectedResult)
    }
    
    func testCharacterContent_WhenDontHaveCharacter_ShouldReturnNil() {
        let index = 1
        let characterContent = sut.characterContent(for: index)
        
        XCTAssertEqual(characterContent, nil)
    }
    
    // MARK: didSelectCharacter
    
    func testDidSelectCharacter_WhenCalledFromViewController_ShouldCallCoordinateToCharacterProfile() {
        let index = 1
        let characterList = CharacterList.mock(hasNextPage: true)
        
        serviceMock.charactersExpectedResult = .success(characterList)
        sut.loadContent(characterName: nil)
        
        sut.didSelectCharacter(at: index)
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToCharacterProfileCount, 1)
        XCTAssertEqual(coordinatorSpy.character, characterList.results[index])
    }
    
    // MARK: getErrorContent
    
    func testGetErrorContent_WhenIsSearchError_ShouldReturnSearchErrorContent() {
        let searchedName = "Rick"
        
        serviceMock.charactersExpectedResult = .failure(.serverError)
        sut.loadContent(characterName: searchedName)
        let errorContent = sut.getErrorContent()
        
        XCTAssertEqual(errorContent.title, Localizable.NotFound.searchErrorTitle(searchedName))
        XCTAssertEqual(errorContent.subtitle, Localizable.NotFound.searchErrorSubtitle)
    }
    
    func testGetErrorContent_WhenIsGenericError_ShouldReturnSearchErrorContent() {
        serviceMock.charactersExpectedResult = .failure(.serverError)
        sut.loadContent(characterName: nil)
        let errorContent = sut.getErrorContent()
        
        XCTAssertEqual(errorContent.title, GlobalLocalizable.GenericError.title)
        XCTAssertEqual(errorContent.subtitle, GlobalLocalizable.GenericError.message)
    }
}
