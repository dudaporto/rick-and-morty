import UIKit

enum ButtonStyle {
    case primary
    case secondary
}

final class RMButton: UIButton {
    private let defaultHeight: CGFloat = 45
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Palette.green1.color.withAlphaComponent(0.1) : Palette.background.color
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
    
    private func setStyle(_ style: ButtonStyle) {
        setCommonStyle()
        
        switch style {
        case .primary:
            setPrimaryStyle()
        case .secondary:
            setSecondaryStyle()
        }
    }
    
    private func setPrimaryStyle() {
        border(color: Palette.green1.color, width: 1, opacity: 1, radius: Radius.medium)
        backgroundColor = Palette.background.color
        setTitleColor(Palette.green1.color, for: [])
    }
    
    private func setSecondaryStyle() {
        border(radius: Radius.medium)
        backgroundColor = Palette.background.color
        setTitleColor(Palette.gray3.color, for: [])
    }
    
    private func setCommonStyle() {
        titleLabel?.font = Typography.highlightTertiaryTitle
    }
    
    init(style: ButtonStyle) {
        super.init(frame: .zero)
        setStyle(style)
        height(defaultHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTap() {
        action?()
    }
}
