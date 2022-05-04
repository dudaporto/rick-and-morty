struct CharacterEpisodeContent {
    private let episode: Episode
    let hideSeparatorView: Bool
    
    init(episode: Episode, hideSeparatorView: Bool) {
        self.episode = episode
        self.hideSeparatorView = hideSeparatorView
    }
    
    var episodeDescription: String {
        episode.episode + ":"
    }
    
    var name: String {
        episode.name
    }
}
