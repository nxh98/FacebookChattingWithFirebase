//
//  FriendsViewController.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SVProgressHUD

final class FriendsViewController: ViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var viewModel: FriendsViewModel = FriendsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        loadApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Private functions
    private func configCollectionView() {
        let nib = UINib(nibName: "FriendsCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func loadApi() {
        SVProgressHUD.show()
        DispatchQueue.global().async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.viewModel.getFriends { [weak self] result in
                guard let this = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        this.collectionView.reloadData()
                    }
                default:
                    break
                }
            }
            dispatchGroup.leave()
            dispatchGroup.enter()
            self.viewModel.getUser { [weak self] result in
            guard let this = self else { return }
                SVProgressHUD.popActivity()
                switch result {
                case .success:
                    guard let idCurrentUser = this.viewModel.user?.id else { return }
                    Session.shared.idCurrentUser = idCurrentUser
                default:
                    break
                }
            }
            dispatchGroup.leave()
        }
    }
}

extension FriendsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendsCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.getFriendForIndexPath(atIndexPath: indexPath)
        return cell
    }
}

extension FriendsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let midSpace: CGFloat = 5
        let width: CGFloat = (collectionView.width / 2) - midSpace
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
}

extension FriendsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FriendsProfileViewController()
        guard let friend = viewModel.getFriendForIndexPath(atIndexPath: indexPath) else { return }
        Session.shared.idFriend = friend.id
        vc.viewModel.nameUser = friend.name
        navigationController?.pushViewController(vc)
    }
}
