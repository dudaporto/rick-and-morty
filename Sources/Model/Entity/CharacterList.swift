struct CharacterList: Decodable {
    let info: PaginationInfo
    let results: [Character]
}
