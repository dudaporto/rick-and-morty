@testable import RickAndMorty
import XCTest

private final class HomeViewCoordinatorSpy: HomeCoordinatorType {
    private(set) var callCoordinateToCharacterListCount = 0
    
    var viewController: UIViewController?
    
    func coordinateToCharacterList() {
        callCoordinateToCharacterListCount += 1
    }
}

final class HomeViewModelTests: XCTestCase {
    private let coordinatorSpy = HomeViewCoordinatorSpy()
    private lazy var sut = HomeViewModel(coordinator: coordinatorSpy)
    
    func testGoToCharacterList_WhenCalledFromViewController_ShouldCallCoordianteToCharacterList() {
        sut.goToCharacterList()
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToCharacterListCount, 1)
    }
}
