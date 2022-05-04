import UIKit

final class HomeViewController: UIViewController {
    private typealias Localizable = Strings.Home
    
    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView(image: Images.homePoster.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.largeTitle
        label.text = Localizable.title
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subtitle
        label.text = Localizable.appDescription
        label.numberOfLines = 0
        label.textColor = Palette.gray2.color
        label.textAlignment = .center
        return label
    }()
    
    private lazy var charactersButton: RMButton = {
        let button = RMButton()
        button.text = Localizable.charactersButtonTitle
        button.action = { self.showCharacterList() }
        return button
    }()
    
    private lazy var welcomeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            posterImage, titleLabel, descriptionLabel, charactersButton
        ])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space4)
        return stackView
    }()
    
    private lazy var developedLabel: UILabel = {
        let label = UILabel()
        label.attributedText = Localizable.developed.withBoldText(text: Localizable.developedBoldFragment,
                                                                  regularFont: Typography.info,
                                                                  boldFont: Typography.highlightTertiaryTitle)
        label.textColor = Palette.gray2.color
        return label
    }()
    
    private lazy var githubIcon: UIImageView = {
        let image = UIImageView(image: Images.github.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Palette.gray4.color
        return image
    }()
    
    private lazy var developedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [developedLabel, githubIcon])
        stackView.axis = .horizontal
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var poweredLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.info
        label.attributedText = Localizable.powered.withBoldText(text: Localizable.poweredBoldFragment,
                                                                regularFont: Typography.info,
                                                                boldFont: Typography.highlightTertiaryTitle)
        label.textColor = Palette.gray2.color
        return label
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [developedStackView, poweredLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space3)
        return stackView
    }()
    
    private let viewModel: HomeViewModelType
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func showCharacterList() {
        viewModel.goToCharacterList()
    }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacing.space4),
            welcomeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        posterImage.height(270)
        githubIcon.size(20)
    }
    
    func setupHierarchy() {
        view.addSubviews(welcomeStackView, footerStackView)
    }
    
    func setupStyles() {
        view.backgroundColor = Palette.background.color
    }
}
