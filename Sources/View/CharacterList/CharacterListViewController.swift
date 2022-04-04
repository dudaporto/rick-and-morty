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
        return tableView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = Palette.green1.color
        return loading
    }()
    
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
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CLICOU \(indexPath.row)")
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItens()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier, for: indexPath)
        guard let characterCell = cell as? CharacterListCell,
              let content = viewModel.characterContent(for: indexPath.row) else {
            return UITableViewCell()
        }
        
        characterCell.setup(with: content)
        characterCell.selectionStyle = .none
        viewModel.loadImage(for: characterCell, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerStackView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
        guard !string.isEmpty else {
            viewModel.fetchCharacters()
            return true
        }
        
        let newText = (textField.text ?? "") + string
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
