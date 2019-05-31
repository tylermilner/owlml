//
//  SelectionPreviewCollectionViewCell.swift
//  OWLML
//
//  Created by Tyler Milner on 5/22/19.
//  Copyright © 2019 Tyler Milner. All rights reserved.
//

import UIKit

class SelectionPreviewCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var imageView: UIImageView!
    
    // MARK: - Overrides
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    // MARK: - Public
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
}
