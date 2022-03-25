//
//  CharacterListCell.swift
//  RickAndMorty
//
//  Created by Maria Porto on 08/03/22.
//

import UIKit

extension CharacterListCell.Constants {
    enum Insets {
        static let cell = UIEdgeInsets(vertical: Spacing.space1)
    }
    
    enum Size {
        static let image: CGFloat = 120
        static let status: CGFloat = 12
    }
    
    enum Opacity {
        static let darkBorder: CGFloat = 0.4
        static let lightBorder: CGFloat = 0.25
        static let shadow: Float = 0.1
    }
}

final class CharacterListCell: UITableViewCell {
    fileprivate enum Constants { }
    
    private typealias Localizable = Strings.CharacterList.CharacterCell
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightTitle
        label.textColor = Palette.gray4.color
        return label
    }()
    
    private lazy var statusIndicator: UIView = {
        let cicledView = UIView()
        cicledView.border(radius: Radius.low)
        return cicledView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.info
        label.textColor = Palette.gray3.color
        return label
    }()
    
    private lazy var statusBadgeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusIndicator, statusLabel])
        stackView.axis = .horizontal
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, statusBadgeStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var lastLocationTitle: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightSecondaryTitle
        label.text = Localizable.lastKnownLocation
        label.textColor = Palette.gray4.color
        return label
    }()
    
    private lazy var lastLocationLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.info
        label.textColor = Palette.gray3.color
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lastLocationTitle, lastLocationLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, locationStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space2)
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterImage, labelsStackView])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var cellContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.background.color
        return view
    }()
    
    func setup(name: String, statusColor: UIColor, statusDescription: String, locationDescription: String) {
        nameLabel.text = name
        statusIndicator.backgroundColor = statusColor
        statusLabel.text = statusDescription
        lastLocationLabel.text = locationDescription
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupStyles()
    }
}

extension CharacterListCell: ViewSetup {
    func setupConstraints() {
        cellContainer.fitToParent(with: Constants.Insets.cell)
        rootStackView.fitToParent()
    }
    
    func setupHierarchy() {
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(rootStackView)
        characterImage.size(Constants.Size.image)
        statusIndicator.size(Constants.Size.status)
    }
    
    func setupStyles() {
        let opacity: CGFloat
        switch traitCollection.userInterfaceStyle {
        case .dark:
            opacity = Constants.Opacity.darkBorder
        default:
            opacity = Constants.Opacity.lightBorder
        }
        
        let shadowOffset = CGSize(width: 0, height: 3)
        cellContainer.border(color: Palette.green1.color, width: 1, opacity: opacity, radius: Radius.medium)
        cellContainer.shadow(color: Palette.green1.color,
                             opacity: Constants.Opacity.shadow,
                             offset: shadowOffset,
                             radius: 5)
        
        backgroundColor = Palette.background.color
    }
}
