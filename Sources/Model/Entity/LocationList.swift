struct LocationList: Decodable {
    let info: PaginationInfo
    let results: [Location]
}
