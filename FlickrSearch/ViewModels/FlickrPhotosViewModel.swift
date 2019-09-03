//
//  FlickrPhotosViewModel.swift
//  FlickrPhotosViewModel
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import Foundation
import UIKit

protocol FlickrPhotosViewModelDelegate: class {
    func refreshUI()
    func showError(_ message: String)
}

class FlickrPhotosViewModel {
    private var flickrService = FlickrService()
    private weak var delegate: FlickrPhotosViewModelDelegate?
    private var searches: [FlickrPhoto] = []
    
    init(delegate: FlickrPhotosViewModelDelegate) {
        self.delegate = delegate
        self.flickrService = FlickrService()
    }
    
    // MARK: - Call service
    
    func searchForPhotos(withSearchWord term: String) {
        flickrService.searchFlickr(for: term) { searchResults in
            switch searchResults {
            case .error(let error) :
                self.delegate?.showError(error.localizedDescription)
            case .results(let results):
                self.update(withNewSearches: results.searchResults)
                self.delegate?.refreshUI()
            }
        }
    }
    
    // MARK: - Search updates
    
    func searchesToDisplay() -> [FlickrPhoto]  {
        return searches
    }
    
    func update(withNewSearches searchResults: [FlickrPhoto]) {
        clearSearches()
        
        self.searches = searchResults
    }
    
    func clearSearches() {
        searches = []
    }
    
    var numberOfSearchResults: Int {
        return searches.count
    }
    
    func photo(for indexPath: IndexPath) -> FlickrPhoto {
        return searches[indexPath.row]
    }
    
    // MARK: - Sort
    func sortImagesByRecent() {
        let sortedSearches = searches.sorted(by: { $0.dateTaken > $1.dateTaken })
        
        update(withNewSearches: sortedSearches)
        delegate?.refreshUI()
    }
    
    func sortImagesByOldest() {
        let sortedSearches = searches.sorted(by: { $0.dateTaken < $1.dateTaken })
        
        update(withNewSearches: sortedSearches)
        delegate?.refreshUI()
    }
    
    // MARK: - CollectionView updates
    
    struct FlickrViewConstants {
        static let reuseIdentifier = "FlickrCell"
        static let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom:0.0, right: 20.0)
        static let itemsPerRow: CGFloat = 1
    }
    
    var itemSectionInsets: UIEdgeInsets {
        return FlickrViewConstants.sectionInsets
    }
    
    var itemReuseIdentifier: String {
        return FlickrViewConstants.reuseIdentifier
    }
    
    func itemSize(inViewWidth viewWidth: CGFloat) -> CGSize {
        let paddingSpace = FlickrViewConstants.sectionInsets.left * (FlickrViewConstants.itemsPerRow + 1)
        let availableWidth = viewWidth - paddingSpace
        let widthPerItem = availableWidth / FlickrViewConstants.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
