//
//  FlickrPhotosViewController.swift
//  FlickrPhotosViewController
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import UIKit

final class FlickrPhotosViewController: UICollectionViewController {
    
    var viewModel: FlickrPhotosViewModel!
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FlickrPhotosViewModel(delegate: self)
    }
}

// MARK: - Text Field Delegate
extension FlickrPhotosViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.addSubview(activityIndicator)
        
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        self.viewModel.searchForPhotos(withSearchWord: textField.text!)
        
        textField.text = nil
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension FlickrPhotosViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfSearchResults
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.viewModel.itemReuseIdentifier,
                                                      for: indexPath) as! FlickrPhotoCell
        let flickrPhoto = self.viewModel.photo(for: indexPath)
        
        cell.setup(withPhoto: flickrPhoto)
        
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.itemSize(inViewWidth: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.viewModel.itemSectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.itemSectionInsets.left
    }
}

// MARK: - FlickrPhotosViewModelDelegate
extension FlickrPhotosViewController: FlickrPhotosViewModelDelegate {
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func refreshUI() {
        self.collectionView?.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            alert.removeFromParent()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
