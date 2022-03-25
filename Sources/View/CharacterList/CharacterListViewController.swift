//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Maria Porto on 10/12/21.
//

import UIKit

extension CharacterListViewController.Constants {
    enum Insets {
        static var tableView = UIEdgeInsets(horizontal: Spacing.space3)
        static var header = UIEdgeInsets(vertical: Spacing.space2)
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
        search.backgroundColor = Palette.gray0.color
        search.textColor = Palette.gray2.color
        search.tintColor = Palette.gray2.color
        search.placeholder = Localizable.searchBarPlaceholder
        return search
    }()

    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [subtitleLabel, searchField])
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
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        title = Localizable.title
    }
}

// MARK: - ViewSetup
extension CharacterListViewController: ViewSetup {
    func setupConstraints() {
        tableView.fitToParent(with: Constants.Insets.tableView)
        searchField.height(60)
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier, for: indexPath)
        guard let characterCell = cell as? CharacterListCell else {
            return UITableViewCell()
        }
        characterCell.setup(name: "Rick", statusColor: .green, statusDescription: "Alive", locationDescription: "Earth")
        characterCell.selectionStyle = .none
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
