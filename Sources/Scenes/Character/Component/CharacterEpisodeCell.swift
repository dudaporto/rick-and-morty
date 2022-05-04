import UIKit

final class CharacterEpisodeCell: UITableViewCell {
    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightSecondaryTitle
        label.textColor = Palette.green1.color
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title
        label.textColor = Palette.gray2.color
        return label
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [episodeLabel, episodeNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = Spacing.space1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space3)
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.green1.color
        view.alpha = 0.15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setup(content: CharacterEpisodeContent) {
        episodeLabel.text = content.episodeDescription
        episodeNameLabel.text = content.name
        separatorView.isHidden = content.hideSeparatorView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CharacterEpisodeCell: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.space3),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupHierarchy() {
        contentView.addSubviews(rootStackView, separatorView)
    }
    
    func setupStyles() {
        backgroundColor = Palette.background.color
        selectionStyle = .none
    }
}

