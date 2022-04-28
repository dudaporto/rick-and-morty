protocol HomeViewModelType: AnyObject {
    func goToCharacterList()
}

final class HomeViewModel: HomeViewModelType {
    private let coordinator: HomeCoordinatorType
    
    init(coordinator: HomeCoordinatorType) {
        self.coordinator = coordinator
    }
    
    func goToCharacterList() {
        coordinator.coordinateToCharacterList()
    }
}
