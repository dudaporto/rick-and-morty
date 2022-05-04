import UIKit

protocol CharacterViewControllerType: ImageReceiver {
    func displayCharacterHeader(name: String, statusColor: UIColor, statusDescription: String)
    func displayEpisodes()
}

final class CharacterViewController: UIViewController {
    typealias Localizable = Strings.CharacterProfile
    
    enum Section: Int, CaseIterable {
        case about
        case episodes
        
        var title: String {
            switch self {
            case .about:
                return Localizable.aboutSectionTitle
            case .episodes:
                return Localizable.episodesSectionTitle
            }
        }
    }
    
    private lazy var characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var characterTitle: UILabel = {
        let name = UILabel()
        name.font = Typography.largeTitle
        return name
    }()
    
    private lazy var favoriteIcon: UIImageView = {
        let image = UIImageView()
        image.image = Images.heartFilled.image
        image.tintColor = Palette.green1.color
        return image
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterTitle, favoriteIcon])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        return stackView
    }()
    
    private lazy var statusIndicator: UIView = {
        let cicledView = UIView()
        cicledView.border(radius: Radius.low)
        return cicledView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title
        label.textColor = Palette.gray3.color
        return label
    }()
    
    private lazy var statusBadgeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusIndicator, statusLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.space2
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameStackView, statusBadgeStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterInfoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.background.color
        view.border(radius: Radius.medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = .zero
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var topBarHeight: CGFloat {
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let safeAreaTop = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        return navBarHeight + safeAreaTop
    }
    
    private let viewModel: CharacterViewModelType
    var currentDownloadTask: Cancellable?
    
    init(viewModel: CharacterViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        viewModel.fetchCharacterInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradient()
    }
    
    private func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.black.withAlphaComponent(0.7).cgColor,
                           UIColor.black.withAlphaComponent(0.4).cgColor,
                           UIColor.clear.cgColor]
        gradient.locations = [0, 0.25, 1]
        
        gradientView.layer.sublayers?.removeAll()
        gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

extension CharacterViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: view.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterImage.widthAnchor.constraint(equalTo: characterImage.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            characterInfoContainer.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: -Spacing.space5),
            characterInfoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterInfoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterInfoContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: characterInfoContainer.leadingAnchor, constant: Spacing.space3),
            headerStackView.topAnchor.constraint(equalTo: characterInfoContainer.topAnchor, constant: Spacing.space3),
            headerStackView.trailingAnchor.constraint(equalTo: characterInfoContainer.trailingAnchor, constant: -Spacing.space3)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: topBarHeight)
        ])
    
        NSLayoutConstraint.activate([
            infoTableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: Spacing.space2),
            infoTableView.leadingAnchor.constraint(equalTo: characterInfoContainer.leadingAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: characterInfoContainer.trailingAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: characterInfoContainer.bottomAnchor)
        ])
        
        statusIndicator.size(12)
        favoriteIcon.size(30)
    }
    
    func setupHierarchy() {
        view.addSubviews(characterImage, characterInfoContainer, gradientView)
        characterInfoContainer.addSubviews(headerStackView, infoTableView)
    }
    
    func setupStyles() {
        setupNavigationBar()
    }
}

extension CharacterViewController: CharacterViewControllerType {
    func displayCharacterHeader(name: String, statusColor: UIColor, statusDescription: String) {
        characterTitle.text = name
        statusIndicator.backgroundColor = statusColor
        statusLabel.text = statusDescription
    }
    
    func displayEpisodes() {
        infoTableView.reloadData()
    }
}

extension CharacterViewController {
    func setImage(_ image: UIImage) {
        characterImage.image = image
    }
}

// MARK: - UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItens(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .about:
            return infoCell(for: indexPath)
            
        case .episodes:
            return episodeCell(for: indexPath)
            
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let infoSection = Section(rawValue: section) else { return nil }
        
        let headerTile = UITextView()
        headerTile.font = Typography.highlightSecondaryTitle
        headerTile.textContainerInset = UIEdgeInsets(top: Spacing.space4,
                                                     left: Spacing.space2,
                                                     bottom: Spacing.space2,
                                                     right: Spacing.space2)
        headerTile.isSelectable = false
        headerTile.backgroundColor = .clear
        headerTile.textColor = Palette.gray3.color
        headerTile.text = infoSection.title
        return headerTile
    }
}

private extension CharacterViewController {
    func infoCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let content = viewModel.characterInfo(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = CharacterInfoCell(style: .default, reuseIdentifier: CharacterInfoCell.identifier)
        cell.setup(content: content)
        return cell
    }
    
    func episodeCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let content = viewModel.episodeInfo(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = CharacterEpisodeCell(style: .default, reuseIdentifier: CharacterEpisodeCell.identifier)
        cell.setup(content: content)
        return cell
    }
}
