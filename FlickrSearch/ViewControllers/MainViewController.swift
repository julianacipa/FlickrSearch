//
//  MainViewController.swift
//  FlickrSearch
//
//  Created by Juliana Cipa on 02/09/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func searchTermEntered(searchTerm: String)
    func sortImagesByRecentSelected()
    func sortImagesByOldestSelected()
}

final class MainViewController: UIViewController {
    
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!
    
    var flickrPhotosViewController: MainViewControllerDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let flickrPhotosVC = segue.destination as? FlickrPhotosViewController {
            flickrPhotosVC.mainDelegate = self
            
            flickrPhotosViewController = flickrPhotosVC
        } else {
            return
        }
    }
    
    @IBAction func segmentedControlValueChanged() {
        switch sortingSegmentedControl.selectedSegmentIndex {
        case 0:
            flickrPhotosViewController?.sortImagesByRecentSelected()
        case 1:
            flickrPhotosViewController?.sortImagesByOldestSelected()
        default:
            break
        }
    }
}

extension MainViewController: MainViewDelegate {
    func resetSegmentedControl() {
        self.sortingSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.flickrPhotosViewController?.searchTermEntered(searchTerm: searchBar.text!)
    }
}

