//
//  ChatViewController.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class ChatViewController: ViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textInput: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var attachButton: UIButton!
    
    // MARK: - Properties
    private var viewModel: ChatViewModel = ChatViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        loadMessages()
    }
    
    // MARK: - Private functions
    private func configUI() {
        textInput.layer.cornerRadius = 15
        tabBarController?.tabBar.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SenderCell", bundle: nil), forCellReuseIdentifier: "SenderCell")
    }
    
    private func loadMessages() {
        viewModel.loadMessagesOnTableView(tableView: tableView)
    }
    
    // MARK: - @IBAction
    @IBAction func sendButtonTouchUpInside(_ sender: UIButton) {
        guard let text = textInput.text else {
            return
        }
        viewModel.postMessageToFirebase(body: text)
        textInput.text = ""
    }
}

// MARK: - extension
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as? SenderCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.getMessageForIndexPaht(atIndexPath: indexPath)
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
