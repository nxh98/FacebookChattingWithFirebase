//
//  ConversationsViewController.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import RealmSwift

final class ConversationsViewController: ViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var viewModel: ConversationsViewModel = ConversationsViewModel()
    private let searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
    private var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    private var timer: Timer = Timer()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavi()
        configTabbleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tapGesture.isEnabled = false
        tableView.resignFirstResponder()
    }
    
    // MARK: - Private functions
    private func configTabbleView() {
        let nib = UINib(nibName: "ConversationsCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(tableViewTouchUpInside))
    }
    
    private func configNavi() {
        searchBar.delegate = self
        searchBar.placeholder = "Tìm kiếm..."
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func fetchData() {
        viewModel.fetchData { [weak self] done in
            guard let this = self else { return }
            switch done {
            case true:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    this.tableView.reloadData()
                })
            default:
                break
            }
        }
    }
    
    @objc private func tableViewTouchUpInside() {
        searchBar.resignFirstResponder()
        tapGesture.isEnabled = false
    }
}

extension ConversationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConversationsCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.getFriendForIndexPath(atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Ẩn") { (_, _, success) in
            do {
                let realm = try Realm()
                let result = realm.objects(Friends.self)
                try realm.write {
                    realm.delete(result[indexPath.row])
                    DispatchQueue.main.async {
                        self.fetchData()
                        tableView.reloadData()
                    }
                }
            } catch {
                return
            }
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension ConversationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatViewController = ChatViewController()
        guard let idReceiver = viewModel.getFriendForIndexPath(atIndexPath: indexPath)?.id,
            let name = viewModel.getFriendForIndexPath(atIndexPath: indexPath)?.name else { return }
        chatViewController.viewModel.nameSender = name
        chatViewController.viewModel.idReceiver = idReceiver
        searchBar.text = nil
        navigationController?.pushViewController(chatViewController)
    }
}

extension ConversationsViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tapGesture.isEnabled = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        if searchText.isEmpty {
            self.fetchData()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
                do {
                    let realm = try Realm()
                    let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
                    let results = realm.objects(Friends.self).filter(predicate)
                    self.viewModel.friends = Array(results)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    return
                }
            }
        }
    }
}
