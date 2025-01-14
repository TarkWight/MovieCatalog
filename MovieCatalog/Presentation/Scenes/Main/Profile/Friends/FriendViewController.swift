//
//  FriendViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//


import UIKit

final class FriendViewController: BaseViewController {
    private let viewModel: FriendViewModel

    // MARK: - UI Elements
    private let tableView = UITableView()

    // MARK: - Initializer
    init(viewModel: FriendViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle("Friends")
        setupUI()
        bindViewModel()
        viewModel.handle(.fetchFriends)
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Binding
    private func bindViewModel() {
        viewModel.onFriendsLoaded = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { [weak self] errorMessage in
//            self?.showError(errorMessage)
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension FriendViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = viewModel.friends[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = viewModel.friends[indexPath.row]
//        viewModel.handle(.selectFriend(friend.id))
    }
}
