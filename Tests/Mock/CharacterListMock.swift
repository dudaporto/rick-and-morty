@testable import RickAndMorty
import Foundation

extension CharacterList {
    static func mock(hasNextPage: Bool) -> CharacterList {
        let nextPage = hasNextPage ? URL(string: "https://rickandmortyapi.com/api/episode/1")! : nil
        let paginationInfo = PaginationInfo(next: nextPage)
        
        return CharacterList(info: paginationInfo, results: [.mock, .mock2])
    }
}

extension CharacterListCellContent: Equatable {
    public static func == (lhs: CharacterListCellContent, rhs: CharacterListCellContent) -> Bool {
        lhs.name == rhs.name
        && lhs.locationDescription == rhs.locationDescription
        && lhs.statusColor == rhs.statusColor
        && lhs.statusDescription == rhs.statusDescription
    }
}
