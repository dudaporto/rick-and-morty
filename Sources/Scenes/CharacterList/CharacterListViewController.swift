//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Maria Porto on 10/12/21.
//

import UIKit

protocol CharacterListViewControllerType: AnyObject {
    func displayCharacters()
    func displayError()
    func startLoading()
    func stopLoading()
}

extension CharacterListViewController.Constants {
    enum Insets {
        static var tableView = UIEdgeInsets(horizontal: Spacing.space3)
        static var header = UIEdgeInsets(vertical: Spacing.space2)
        static var infoView = UIEdgeInsets(inset: Spacing.space3)
    }
}

final class CharacterListViewController: UIViewController {
    fileprivate enum Constants { }
    
    enum Section: Int, CaseIterable {
        case characters
        case infoView
    }
    
    private typealias Localizable = Strings.CharacterList
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.title
        label.text = Localizable.subtitle
        label.numberOfLines = 0
        label.textColor = Palette.gray2.color
        return label
    }()

    private lazy var searchField: UISearchTextField = {
        let search = UISearchTextField()
        search.tintColor = Palette.green1.color
        search.placeholder = Localizable.searchBarPlaceholder
        search.delegate = self
        search.returnKeyType = .search
        return search
    }()

    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Spacing.space2
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = Constants.Insets.header
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.isHidden = true
        tableView.tableHeaderView = headerStackView
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        return tableView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = Palette.green1.color
        return loading
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }

    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        let width = view.bounds.width - Spacing.space5
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: width, height: 0)).height
    }
    
    private lazy var errorInfoView: InfoView = {
        let infoView = InfoView()
        infoView.setup(with: .genericError)
        infoView.delegate = self
        infoView.isHidden = true
        return infoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.title
        buildView()
        viewModel.fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStyles()
    }
    
    private let viewModel: CharacterListViewModelType
    
    init(viewModel: CharacterListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewSetup
extension CharacterListViewController: ViewSetup {
    func setupConstraints() {
        tableView.fitToParent(with: Constants.Insets.tableView)
        loadingView.fitToParent()
        errorInfoView.fitToParent(with: Constants.Insets.infoView)
    }
    
    func setupHierarchy() {
        view.addSubviews(tableView, loadingView, errorInfoView)
        headerStackView.addArrangedSubviews(subtitleLabel, searchField)
    }
    
    func setupStyles() {
        view.backgroundColor = Palette.background.color
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = Palette.green1.color
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section) {
        case .characters:
            viewModel.didSelectCharacter(at: indexPath.row)
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItens(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .characters:
            return characterCell(for: indexPath)
            
        case .infoView:
            return infoViewCell(for: indexPath)
            
        case .none:
            return UITableViewCell()
        }
    }
}

private extension CharacterListViewController {
    func characterCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier, for: indexPath)
        guard let characterCell = cell as? CharacterListCell,
              let content = viewModel.characterContent(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        characterCell.setup(with: content)
        viewModel.loadImage(for: characterCell, at: indexPath.row)
        return cell
    }
    
    func infoViewCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = CharacterNotFoundInfoCell(style: .default, reuseIdentifier: CharacterNotFoundInfoCell.identifier)
        cell.setup(characterName: viewModel.getRearchedName())
        return cell
    }
}

extension CharacterListViewController: CharacterListViewControllerType {
    func displayCharacters() {
        tableView.reloadData()
        tableView.isHidden = false
        errorInfoView.isHidden = true
    }
    
    func displayError() {
        errorInfoView.isHidden = false
    }
    
    func startLoading() {
        loadingView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.stopAnimating()
    }
}

extension CharacterListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        viewModel.fetchCharacters()
        view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fieldText = (textField.text ?? "") as NSString
        let newText = fieldText.replacingCharacters(in: range, with: string)
        viewModel.filterCharacters(name: newText)
        return true
    }
}

extension CharacterListViewController: InfoViewDelegate {
    func didTapPrimaryButton() {
        viewModel.fetchCharacters()
    }
    
    func didTapSecondaryButton() {
        // to do
    }
}
