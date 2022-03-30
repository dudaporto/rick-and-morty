import UIKit

protocol InfoViewDelegate: AnyObject {
    func didTapPrimaryButton()
    func didTapSecondaryButton()
}

final class InfoView: UIView {
    weak var delegate: InfoViewDelegate?
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightTitle
        label.textColor = Palette.gray4.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title
        label.textColor = Palette.gray2.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = Spacing.space1
        stack.alignment = .center
        return stack
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, labelsStackView, buttonsStackView])
        stack.axis = .vertical
        stack.spacing = Spacing.space4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var primaryButton: RMButton = {
        let button = RMButton(style: .primary)
        button.action = { self.delegate?.didTapPrimaryButton() }
        return button
    }()
    
    private lazy var secondaryButton: RMButton = {
        let button = RMButton(style: .secondary)
        button.action = { self.delegate?.didTapSecondaryButton() }
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [primaryButton, secondaryButton])
        stack.axis = .vertical
        stack.spacing = Spacing.space1
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with content: InfoViewContent) {
        imageView.image = content.image
        titleLabel.text = content.title
        descriptionLabel.text = content.description
        primaryButton.text = content.primaryButtonTitle
        secondaryButton.text = content.secondaryButtonTitle
        primaryButton.isHidden = content.primaryButtonTitle == nil
        secondaryButton.isHidden = content.secondaryButtonTitle == nil
    }
}

extension InfoView: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupHierarchy() {
        addSubview(rootStackView)
    }
    
    func setupStyles() {
        backgroundColor = Palette.background.color
    }
}
