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
    private(set) var calledCharacterFilter: CharacterFilter?
    var charactersExpectedResult: Result<CharacterList, ApiError>?
    
    
    func getCharacters(filter: CharacterFilter, completion: @escaping NetworkResponse<CharacterList>) {
        calledCharacterFilter = filter
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
    
    func testCharacterContent_WhenDoesntHaveCharacter_ShouldReturnNil() {
        let index = 1
        let characterContent = sut.characterContent(for: index)
        
        XCTAssertEqual(characterContent, nil)
    }
    
    // MARK: didChangeSearchName
    
    func testDidChangeSearchName_WhenCalledFromViewController_ShouldFetchFilteredCharacters() {
        serviceMock.charactersExpectedResult = .success(.mock(hasNextPage: true))
        sut.didChangeSearchName(name: "Rick")
        
        let _ = XCTWaiter.wait(for: [expectation(description: "Wait typing delay")], timeout: 0.5)
        XCTAssertEqual(viewControllerSpy.callStartLoadingCount, 1)
        XCTAssertEqual(viewControllerSpy.callStopLoadingCount, 1)
        XCTAssertEqual(viewControllerSpy.callDisplayCharactersCount, 2)
        XCTAssertEqual(serviceMock.calledCharacterFilter?.name, "Rick")
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
    
    func testGetErrorContent_WhenItsSearchError_ShouldReturnSearchErrorContent() {
        let searchedName = "Rick"
        
        serviceMock.charactersExpectedResult = .failure(.serverError)
        sut.loadContent(characterName: searchedName)
        let errorContent = sut.getErrorContent()
        
        XCTAssertEqual(errorContent.title, Localizable.NotFound.searchErrorTitle(searchedName))
        XCTAssertEqual(errorContent.subtitle, Localizable.NotFound.searchErrorSubtitle)
    }
    
    func testGetErrorContent_WhenItsGenericError_ShouldReturnSearchErrorContent() {
        serviceMock.charactersExpectedResult = .failure(.serverError)
        sut.loadContent(characterName: nil)
        let errorContent = sut.getErrorContent()
        
        XCTAssertEqual(errorContent.title, GlobalLocalizable.GenericError.title)
        XCTAssertEqual(errorContent.subtitle, GlobalLocalizable.GenericError.message)
    }
    
    // MARK: loadContent
    
    func testLoadContent_WhenDoesntHaveName_ShouldClearListAndDisplayCharacters() {
        serviceMock.charactersExpectedResult = .success(.mock(hasNextPage: true))
        sut.loadContent(characterName: nil)
        
        XCTAssertEqual(viewControllerSpy.callStartLoadingCount, 1)
        XCTAssertEqual(viewControllerSpy.callStopLoadingCount, 1)
        XCTAssertEqual(viewControllerSpy.callDisplayCharactersCount, 2)
        XCTAssertEqual(serviceMock.calledCharacterFilter?.name, nil)
    }
    
    func testLoadContent_WhenHasName_ShouldClearListAndDisplayFilteredCharacters() {
        serviceMock.charactersExpectedResult = .success(.mock(hasNextPage: true))
        sut.loadContent(characterName: "Rick")
        
        XCTAssertEqual(viewControllerSpy.callStartLoadingCount, 1)
        XCTAssertEqual(viewControllerSpy.callStopLoadingCount, 1)
        XCTAssertEqual(viewControllerSpy.callDisplayCharactersCount, 2)
        XCTAssertEqual(serviceMock.calledCharacterFilter?.name, "Rick")
    }
    
    // MARK: loadMoreCharacters
    
    func testLoadMoreCharacters_WhenReturnSuccess_ShouldDisplayCharactersAndIncreasePage() {
        serviceMock.charactersExpectedResult = .success(.mock(hasNextPage: true))
        sut.loadMoreCharacters()
        
        XCTAssertEqual(viewControllerSpy.callStartLoadingCount, 0)
        XCTAssertEqual(viewControllerSpy.callDisplayCharactersCount, 1)
        XCTAssertEqual(serviceMock.calledCharacterFilter?.page, sut.filter.page)
    }
    
    func testLoadMoreCharacters_WhenReturnFailure_ShouldDisplayCharactersAndDicreasePage() {
        serviceMock.charactersExpectedResult = .failure(.serverError)
        sut.loadMoreCharacters()
        
        XCTAssertEqual(viewControllerSpy.callStartLoadingCount, 0)
        XCTAssertEqual(viewControllerSpy.callDisplayCharactersCount, 1)
        XCTAssertEqual(sut.filter.page, (serviceMock.calledCharacterFilter?.page ?? 0) - 1)
    }
    
    // MARK: numberOfItens
    
    func testNumberOfItens_WhenItsCharacterSection_ShouldReturnCharactersCount() {
        let charactersList = CharacterList.mock(hasNextPage: true)
        
        serviceMock.charactersExpectedResult = .success(charactersList)
        sut.loadContent(characterName: nil)
        let numberOfItens = sut.numberOfItens(for: 0)
        
        XCTAssertEqual(numberOfItens, charactersList.results.count)
    }
    
    func testNumberOfItens_WhenItsInfoViewSectionAndShouldDisplayError_ShouldReturnOne() {
        serviceMock.charactersExpectedResult = .failure(.serverError)
        sut.loadContent(characterName: nil)
        let numberOfItens = sut.numberOfItens(for: 1)
        
        XCTAssertEqual(numberOfItens, 1)
    }
    
    func testNumberOfItens_WhenItsInfoViewSectionAndShouldntDisplayError_ShouldReturnZero() {
        serviceMock.charactersExpectedResult = .success(.mock(hasNextPage: true))
        sut.loadContent(characterName: nil)
        let numberOfItens = sut.numberOfItens(for: 1)
        
        XCTAssertEqual(numberOfItens, 0)
    }
    
    func testNumberOfItens_WhenItsSeeMoreSectionAndHasNextPage_ShouldReturnoOne() {
        serviceMock.charactersExpectedResult = .success(.mock(hasNextPage: true))
        sut.loadContent(characterName: nil)
        let numberOfItens = sut.numberOfItens(for: 2)
        
        XCTAssertEqual(numberOfItens, 1)
    }
    
    func testNumberOfItens_WhenItsSeeMoreSectionAndDoesntaHaveNextPage_ShouldReturnoZero() {
        serviceMock.charactersExpectedResult = .success(.mock(hasNextPage: false))
        sut.loadContent(characterName: nil)
        let numberOfItens = sut.numberOfItens(for: 2)
        
        XCTAssertEqual(numberOfItens, 0)
    }
    
    func testNumberOfItens_WhenItsInvalidSection_ShouldReturnoZero() {
        let numberOfItens = sut.numberOfItens(for: 3)
        
        XCTAssertEqual(numberOfItens, 0)
    }
}
