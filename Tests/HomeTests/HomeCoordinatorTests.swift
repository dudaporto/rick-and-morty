@testable import RickAndMorty
import XCTest

final class HomeCoordinatorTests: XCTestCase {
    private let spy = ViewControllerSpy()
    private lazy var sut: HomeCoordinator = {
        let coordinator = HomeCoordinator()
        coordinator.viewController = spy
        return coordinator
    }()
    
    func testCoordinateToCharacterList_WhenCalledFromViewModel_ShouldShowCharactersList() {
        sut.coordinateToCharacterList()
        
        XCTAssertEqual(spy.callShowCount, 1)
        XCTAssertTrue(spy.shownViewController is CharacterListViewController)
    }
}
