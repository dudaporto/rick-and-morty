@testable import RickAndMorty
import XCTest

final class CharacterListCoordinatorTests: XCTestCase {
    private let spy = ViewControllerSpy()
    private lazy var sut: CharacterListCoordinator = {
        let coordinator = CharacterListCoordinator()
        coordinator.viewController = spy
        return coordinator
    }()
    
    func testCoordinateToCharacterList_WhenCalledFromViewModel_ShouldShowCharacter() {
        sut.coordinateToCharacterProfile(with: .mock)
        
        XCTAssertEqual(spy.callShowCount, 1)
        XCTAssertTrue(spy.shownViewController is CharacterViewController)
    }
}
