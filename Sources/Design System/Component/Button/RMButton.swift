import UIKit

final class RMButton: UIButton {
    private let defaultHeight: CGFloat = 45
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Palette.green1.color.withAlphaComponent(0.1) : .clear
        }
    }
    
    var action: (() -> Void)? {
        didSet {
            addTarget(self, action: #selector(didTap), for: .touchUpInside)
        }
    }
    
    var text: String? {
        set {
            setTitle(newValue, for: [])
        }
        get {
            title(for: [])
        }
    }
    
    private func setStyle() {
        border(color: Palette.green1.color, width: 1, opacity: 1, radius: Radius.medium)
        setTitleColor(Palette.green1.color, for: [])
        titleLabel?.font = Typography.highlightTertiaryTitle
    }
    
    init() {
        super.init(frame: .zero)
        setStyle()
        height(defaultHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setStyle()
    }
    
    @objc func didTap() {
        action?()
    }
}
