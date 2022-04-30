import UIKit

extension CharacterInfoCell.Constants {
    enum Insets {
        static let cell = UIEdgeInsets(horizontal: Spacing.space3, vertical: Spacing.space2)
    }

    enum Size {
        static let icon: CGFloat = 24
    }
}

final class CharacterInfoCell: UITableViewCell {
    fileprivate enum Constants { }
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Palette.green1.color
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightSecondaryTitle
        label.textColor = Palette.gray2.color
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title
        label.textColor = Palette.gray2.color
        return label
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .horizontal
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [icon, textsStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = Constants.Insets.cell
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.green1.color
        view.alpha = 0.15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setup(content: CharacterInfoContent) {
        icon.image = content.icon
        titleLabel.text = content.title
        descriptionLabel.text = content.descrition
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

extension CharacterInfoCell: ViewSetup {
    func setupConstraints() {
        icon.size(Constants.Size.icon)
        
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
