import Foundation

struct PaginationInfo: Decodable {
    let count: Int
    let pages: Int
    let next: URL?
    let previous: URL?
}
