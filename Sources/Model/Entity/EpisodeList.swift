enum EpisodeListResponse: Decodable {
    case episode(Episode)
    case episodeArray([Episode])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let data = try? container.decode([Episode].self) {
            self = .episodeArray(data)
            return
        }
        if let data = try? container.decode(Episode.self) {
            self = .episode(data)
            return
        }
        throw DecodingError.typeMismatch(EpisodeListResponse.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Wrong type for Episode"))
    }
}
