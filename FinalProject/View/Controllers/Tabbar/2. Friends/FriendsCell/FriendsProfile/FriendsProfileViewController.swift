//
//  FriendsProfileViewController.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD

final class FriendsProfileViewController: ViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var maskAvatar: UIView!
    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var homeTownLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet private weak var totalFriendLabel: UILabel!
    @IBOutlet private weak var messageButton: UIButton!
    @IBOutlet private weak var maskCoverImage: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var heightConstrantsCollectonView: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel: FriendsProfileViewModel = FriendsProfileViewModel()
    
    let rightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(#imageLiteral(resourceName: "icons8-edit-chat-history-32"), for: .normal)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configCollectionView()
        loadAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        collectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    // MARK: - override func
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UICollectionView {
            if obj == self.collectionView && keyPath == "contentSize" {
                heightConstrantsCollectonView.constant = obj.contentSize.height
            }
        }
    }
    
    // MARK: - Private functions
    private func configUI() {
        scrollView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.maskAvatar.cornerRadius = self.maskAvatar.bounds.width / 2
            self.avatar.cornerRadius = self.avatar.bounds.width / 2
            self.maskCoverImage.roundCorners([.topLeft, .topRight], radius: 20)
            self.messageButton.cornerRadius = 10
            self.messageButton.clipsToBounds = true
            // config navi
            self.navigationController?.navigationBar.tintColor = .black
            let label = UILabel()
            label.textColor = UIColor.white
            label.text = self.viewModel.nameUser
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 23)
            // config left button navi
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            button.setBackgroundImage(#imageLiteral(resourceName: "icons8-chevron-left-48"), for: .normal)
            button.addTarget(self, action: #selector(self.backButtonTouchUpInside), for: .touchUpInside)
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: button), UIBarButtonItem(customView: label)]
            // config right button navi
            self.rightButton.addTarget(self, action: #selector(self.inboxTouchUpInside), for: .touchUpInside)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightButton)
            self.rightButton.alpha = 0
        }
    }
    
    private func configCollectionView() {
        let nib = UINib(nibName: "AlbumCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "AlbumCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func loadAPI() {
        SVProgressHUD.show()
        DispatchQueue.global().async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.viewModel.getDetailFriend { [weak self] (result) in
                guard let this = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        this.updateView()
                        this.scrollView.isHidden = false
                    }
                default:
                    break
                }
            }
            dispatchGroup.leave()
            dispatchGroup.enter()
            self.viewModel.getAllAlbum {[weak self] (result) in
                SVProgressHUD.popActivity()
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
        }
    }
    
    private func updateView() {
        guard let viewModel = viewModel.detailFriend else {
            return
        }
        nameLabel.text = viewModel.name
        titleLabel.text = viewModel.quotes
        homeTownLabel.text = viewModel.homeTown
        locationLabel.text = viewModel.location
        birthdayLabel.text = viewModel.birthday
        totalFriendLabel.text = "\(viewModel.countFriends)"
        genderLabel.text = viewModel.gender
        avatar.setImage(urlString: viewModel.avatar, placeholderImage: #imageLiteral(resourceName: "no-avatar"))
        coverImage.setImage(urlString: viewModel.coverImage, placeholderImage: #imageLiteral(resourceName: "no-image"))
    }
    
    private func addRealm() {
        guard let friend = viewModel.detailFriend  else { return }
        let friends = Friends()
        friends.id = friend.id
        friends.image = friend.avatar
        friends.name = friend.name
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", friend.id)
            let result = realm.objects(Friends.self).filter(predicate)
            if result.first == nil {
                try realm.write {
                    realm.add(friends)
                }
            }
        } catch {
            return
        }
    }
    
    // MARK: - Objc function
    @objc private func backButtonTouchUpInside() {
        navigationController?.popViewController()
    }
    
    @objc private func inboxTouchUpInside() {
        addRealm()
        let vc = ChatViewController()
        guard let id = viewModel.detailFriend?.id else { return }
        vc.viewModel.idReceiver = id
        vc.viewModel.nameSender = viewModel.nameUser
        navigationController?.pushViewController(vc)
    }
    
    // MARK: - @IBAction
    @IBAction private func messageTouchUpInside() {
        inboxTouchUpInside()
    }
}

// MARK: - extension: UICollectionViewDataSource
extension FriendsProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? AlbumCell else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel.getAlbumForCell(atIndexPath: indexPath)
        return cell
    }
}

// MARK: - extension: UICollectionViewDelegate
extension FriendsProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Session.shared.idAlbum = viewModel.albums[indexPath.row].id
        let vc = PhotosAlbumViewController()
        vc.viewModel.nameAlbum = viewModel.albums[indexPath.row].name
        navigationController?.pushViewController(vc)
    }
}

// MARK: - extension: UICollectionViewDelegateFlowLayout
extension FriendsProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let midspace: CGFloat = 3
        let verticalSpace: CGFloat = 40
        let width: CGFloat = collectionView.width / 3 - midspace * 2
        let height: CGFloat = width + verticalSpace
        return CGSize(width: width, height: height)
    }
}

// MARK: - extension: UIScrollViewDelegate
extension FriendsProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.bounds.contains(CGRect(x: messageButton.x, y: messageButton.y + messageButton.height / 2, width: messageButton.width, height: messageButton.height / 2)) {
            UIView.animate(withDuration: 0.2) {
                self.rightButton.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.rightButton.alpha = 0
            }
        }
    }
}
