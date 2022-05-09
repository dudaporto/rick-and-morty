import UIKit

final class RMButton: UIButton {
    private let defaultHeight: CGFloat = 45
    private let isLoadable: Bool
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = Palette.green1.color
        return loading
    }()
    
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
        didSet {
            setTitle(text, for: [])
        }
    }

    init(isLoadable: Bool = false) {
        self.isLoadable = isLoadable
        super.init(frame: .zero)
        setStyle()
        height(defaultHeight)
        addLoadingViewIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setStyle()
    }
}

private extension RMButton {
    func addLoadingViewIfNeeded() {
        guard isLoadable else { return }
        
        addSubview(loadingView)
        loadingView.fitToParent()
    }
    
    func startLoading() {
        guard isLoadable else { return }
        text = ""
        loadingView.startAnimating()
    }

    func setStyle() {
        border(color: Palette.green1.color, width: 1, opacity: 1, radius: Radius.medium)
        setTitleColor(Palette.green1.color, for: [])
        titleLabel?.font = Typography.highlightTertiaryTitle
    }
    
    @objc func didTap() {
        startLoading()
        action?()
    }
}
