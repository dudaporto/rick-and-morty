import UIKit

final class CharacterNotFoundInfoCell: UITableViewCell {
    private typealias Localizable = Strings.CharacterList.NotFound
    
    private lazy var infoImage: UIImageView = {
        let image = UIImageView(image: Images.jerryShrug.image)
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightSecondaryTitle
        label.textColor = Palette.gray4.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.info
        label.textColor = Palette.gray2.color
        label.text = Localizable.subtitle
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoImage, labelsStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(vertical: Spacing.space2)
        return stackView
    }()
    
    func setup(characterName: String) {
        titleLabel.text = Localizable.title(characterName)
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

extension CharacterNotFoundInfoCell: ViewSetup {
    func setupConstraints() {
        rootStackView.fitToParent()
        infoImage.size(80)
    }
    
    func setupHierarchy() {
        contentView.addSubview(rootStackView)
    }
    
    func setupStyles() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
