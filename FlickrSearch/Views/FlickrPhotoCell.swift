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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateTakenLabel: UILabel!
    
    func setup(withPhoto flickrPhoto: FlickrPhoto) {
        self.backgroundColor = .white
        
        self.imageView.image = flickrPhoto.thumbnail
        self.titleLabel.text = flickrPhoto.title
        self.authorLabel.text = "by " + flickrPhoto.author.substringBetweenParenthesis()
        self.dateTakenLabel.text = flickrPhoto.dateTaken.shortReadableString()
    }
}
