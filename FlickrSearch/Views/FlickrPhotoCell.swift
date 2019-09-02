//
//  FlickrPhotoCell.swift
//  FlickrPhotoCell
//
//  Created by Juliana Cipa on 30/08/2019.
//  Copyright © 2019 Juliana Cipa. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  
  func setup(withPhoto flickrPhoto: FlickrPhoto) {
    self.backgroundColor = .white

    self.imageView.image = flickrPhoto.thumbnail
  }
}
