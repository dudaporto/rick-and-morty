import UIKit

protocol CharacterNotFoundInfoCellDelegate: AnyObject {
    func didTapTryAgainButton()
}

final class CharacterNotFoundInfoCell: UITableViewCell {
    weak var delegate: CharacterNotFoundInfoCellDelegate?
    
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
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var tryAgainButton: RMButton = {
        let button = RMButton()
        button.text = GlobalLocalizable.GenericError.tryAgain
        button.action = { self.delegate?.didTapTryAgainButton() }
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoImage, labelsStackView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoStackView, tryAgainButton])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(vertical: Spacing.space2)
        return stackView
    }()
    
    func setup(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
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
