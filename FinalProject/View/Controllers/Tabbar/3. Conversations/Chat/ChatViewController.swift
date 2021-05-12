//
//  ChatViewController.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SVProgressHUD

final class ChatViewController: ViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var textInput: UITextView!
    @IBOutlet private weak var heightTextInput: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: ChatViewModel = ChatViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configTextView()
        configNavi()
        loadMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    
    // MARK: - Private functions
    private func configNavi() {
        navigationController?.navigationBar.tintColor = .black
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = viewModel.nameSender
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 23)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "icons8-chevron-left-48"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTouchUpInside), for: .touchUpInside)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: button), UIBarButtonItem(customView: label)]
    }
    
    private func configTableView() {
        tabBarController?.tabBar.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SenderCell", bundle: nil), forCellReuseIdentifier: "SenderCell")
        tableView.register(UINib(nibName: "ReceiverCell", bundle: nil), forCellReuseIdentifier: "ReceiverCell")
        
        let tapGestureTableView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnTableView))
        tableView.addGestureRecognizer(tapGestureTableView)
    }
    
    private func configTextView() {
        textInput.layer.cornerRadius = 15
        textInput.layer.borderWidth = 0.3
        textInput.layer.borderColor = UIColor.red.cgColor
        textInput.text = "Nhập ..."
        textInput.textColor = UIColor.lightGray
        textInput.delegate = self
        heightTextInput.constant = textInput.contentSize.height
    }
    
    private func loadMessages() {
        viewModel.loadMessages { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.tableView.reloadData {
                        let indexPath = IndexPath(row: self.viewModel.numberOfItems(inSection: 0) - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        self.tableView.isHidden = false
                    }
                }
            case .failure(let error):
                self.showAlert(title: AlertKey.notification, message: error.localizedDescription)
            }
        }
    }
    
    // MARK: @Objc functions
    @objc private func backButtonTouchUpInside() {
        navigationController?.popViewController()
    }
    
    @objc private func tapOnTableView() {
        textInput.resignFirstResponder()
    }
    
    // MARK: - @IBAction
    @IBAction private func sendButtonTouchUpInside(_ sender: UIButton) {
        viewModel.postMessageToFirebase(body: textInput.text.content, completion: { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                if this.viewModel.messages.isEmpty {
                    this.loadMessages()
                }
            default:
                break
            }
        })
        textInput.text = nil
        sendButton.isUserInteractionEnabled = false
        sendButton.alpha = 0.5
        heightTextInput.constant = textInput.contentSize.height
    }
}

// MARK: - extension
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.getMessageForIndexPaht(atIndexPath: indexPath)?.isOwner == false {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as? ReceiverCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.getMessageForIndexPaht(atIndexPath: indexPath)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as? SenderCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.getMessageForIndexPaht(atIndexPath: indexPath)
            return cell
        }
    }
}

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ChatViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.content.trimmed.isEmpty {
            sendButton.isUserInteractionEnabled = true
            sendButton.alpha = 1
            if textInput.contentSize.height <= 100 {
                heightTextInput.constant = textInput.contentSize.height
                self.tableView.scrollToBottom()
            }
        } else {
            sendButton.isUserInteractionEnabled = false
            sendButton.alpha = 0.5
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Nhập..."
            textView.textColor = UIColor.lightGray
        }
    }
}
