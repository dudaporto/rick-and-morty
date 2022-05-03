import Foundation

struct Location: Decodable {
    let name: String
    let type: String?
    let dimension: String?
    let residents: [URL]?
}
