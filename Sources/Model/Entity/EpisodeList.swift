struct EpisodeList: Decodable {
    let info: PaginationInfo
    let results: [Episode]
}
