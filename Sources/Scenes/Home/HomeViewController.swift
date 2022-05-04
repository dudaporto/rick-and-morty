import UIKit

final class HomeViewController: UIViewController {
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: Images.background.image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var characterButton: RMButton = {
        let button = RMButton()
        button.text = "See characters"
        button.action = { self.showCharacterList() }
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterButton])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space3)
        stackView.backgroundColor = Palette.background.color
        return stackView
    }()
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        navigationController?.navigationBar.prefersLargeTitles = true
        buildView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradient()
    }
    
    private func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, Palette.background.color.cgColor]
        gradient.locations = [0, 1]
        
        gradientView.layer.sublayers?.removeAll()
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    func showCharacterList() {
        viewModel.goToCharacterList()
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        backgroundImage.fitToParent()
        
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupHierarchy() {
        view.addSubviews(backgroundImage, buttonsStackView, gradientView)
    }
}
