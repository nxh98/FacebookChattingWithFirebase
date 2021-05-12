//
//  PhotosAlbumViewController.swift
//  FinalProject
//
//  Created by NXH on 10/5/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SVProgressHUD

final class PhotosAlbumViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var priorImage: UIImageView!
    @IBOutlet private weak var headerImage: UIImageView!
    @IBOutlet private weak var nameAlbum: UILabel!
    @IBOutlet private weak var containHeaderView: UIView!
    
    // MARK: - Properties
    var viewModel: PhotosAlbumViewModel = PhotosAlbumViewModel()
    private var isLoading: Bool = false
    private var isConfigHeader: Bool = true
    private var timer: Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getPhotos()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    // MARK: - Private function
    private func configUI() {
        containHeaderView.layer.borderWidth = 0.5
        containHeaderView.layer.borderColor = UIColor.black.cgColor
        nameAlbum.text = self.viewModel.nameAlbum
        DispatchQueue.main.async {
            self.containHeaderView.layer.borderWidth = 0.5
            self.containHeaderView.layer.borderColor = UIColor.black.cgColor
            self.nameAlbum.text = self.viewModel.nameAlbum
        }
        configCollectionView()
    }
    
    private func configCollectionView() {
        let nib = UINib(nibName: "PhotosAlbumCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "PhotosAlbumCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func getPhotos() {
        SVProgressHUD.show()
        viewModel.getPhotosInAlbum { [weak self](result) in
            SVProgressHUD.popActivity()
            guard let this = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    this.collectionView.reloadData()
                    this.configHeader(isConfig: this.isConfigHeader)
                    this.isLoading = false
                }
            default:
                break
            }
        }
    }
    
    private func configHeader(isConfig: Bool) {
        if isConfig {
            guard let photos = viewModel.photos?.photos else {
                return
            }
            if photos.isEmpty {
                return
            }
            var index = 0
            headerImage.setImage(urlString: photos[index].image, placeholderImage: #imageLiteral(resourceName: "no-image"))
            UIView.animate(withDuration: 4) {
                self.headerImage.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            }
            
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
                self.timer = timer
                guard let photos = self.viewModel.photos?.photos else {
                    return
                }
                let count = photos.count - 1
                index += 1
                if index > count {
                    timer.invalidate()
                    return
                }
                if self.priorImage.alpha == 0 {
                    self.priorImage.setImage(urlString: photos[index].image, placeholderImage: #imageLiteral(resourceName: "no-image"))
                    UIView.animate(withDuration: 3.5, animations: {
                        self.priorImage.alpha = 1
                        self.headerImage.alpha = 0
                        self.priorImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    }) {_ in
                        UIView.animate(withDuration: 1.5) {
                             self.priorImage.transform = CGAffineTransform(scaleX: 5, y: 5)
                        }
                    }
                } else {
                    self.headerImage.setImage(urlString: photos[index].image, placeholderImage: #imageLiteral(resourceName: "no-image"))
                    UIView.animate(withDuration: 2, animations: {
                        self.priorImage.alpha = 0
                        self.headerImage.alpha = 1
                        self.headerImage.transform = CGAffineTransform(scaleX: 2, y: 2)
                    }) { _ in
                        
                        self.priorImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        UIView.animate(withDuration: 3) {
                            self.headerImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                        }
                    }
                }
            }
            self.isConfigHeader = false
        }
    }
}

// MARK: - extension
extension PhotosAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosAlbumCell", for: indexPath) as? PhotosAlbumCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getPhotosForCell(atIndexPath: indexPath)
        return cell
    }
}

extension PhotosAlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoViewController()
        vc.viewModel.photos = viewModel.photos
        vc.viewModel.index = indexPath.row
        present(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if !isLoading {
                isLoading = true
                getPhotos()
            }
        }
    }
}

extension PhotosAlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let midSpace: CGFloat = 1
        let width: CGFloat = collectionView.width / 3 - midSpace * 2
        return CGSize(width: width, height: width)
    }
}
