//
//  CharacterListCell.swift
//  RickAndMorty
//
//  Created by Maria Porto on 08/03/22.
//

import UIKit

extension CharacterListCell.Contants {
    enum Insets {
        static let cell = UIEdgeInsets(vertical: Spacing.space1)
    }
    
    enum Size {
        static let image: CGFloat = 120
        static let status: CGFloat = 12
    }
}

final class CharacterListCell: UITableViewCell {
    fileprivate enum Contants { }
    
    private typealias Localizable = Strings.CharacterList.CharacterCell
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .green
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.highlightTitle
        return label
    }()
    
    private lazy var statusIndicator: UIView = {
        let cicledView = UIView()
        cicledView.border(radius: 6)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
}

extension CharacterListCell: ViewSetup {
    func setupConstraints() {
        rootStackView.fitToParent(with: Contants.Insets.cell)
    }
    
    func setupHierarchy() {
        contentView.addSubview(rootStackView)
        characterImage.size(Contants.Size.image)
        statusIndicator.size(Contants.Size.status)
    }
    
    func setupStyles() {
        rootStackView.border(color: .green, width: 1, opacity: 0.25, radius: 12)
        backgroundColor = .systemBackground
    }
}
