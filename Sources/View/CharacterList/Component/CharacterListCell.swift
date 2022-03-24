//
//  CharacterListCell.swift
//  RickAndMorty
//
//  Created by Maria Porto on 08/03/22.
//

import UIKit

final class CharacterListCell: UITableViewCell {
    private typealias Localizable = Strings.CharacterList.CharacterCell
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightTitle
        return label
    }()
    
    private lazy var statusIndicator: UIView = {
        let cicledView = UIView()
        cicledView.border(radius: 5)
        return cicledView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.info
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
        return label
    }()
    
    private lazy var lastLocationLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.info
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
    
    func setup(name: String, statusColor: UIColor, statusDescription: String, locationDescription: String) {
        nameLabel.text = name
        statusIndicator.backgroundColor = statusColor
        statusLabel.text = statusDescription
        lastLocationLabel.text = locationDescription
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
}

extension CharacterListCell: ViewSetup {
    func setupConstraints() {
        addSubview(rootStackView)
    }
    
    func setupHierarchy() {
        rootStackView.fitToParent()
    }
    
    func setupStyles() {
        border(color: .green, width: 1, opacity: 0.25, radius: 12)
    }
}
