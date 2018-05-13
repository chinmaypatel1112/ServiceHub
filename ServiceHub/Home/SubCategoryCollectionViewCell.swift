//
//  SubCategoryCollectionViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/19/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subcategoryImage: UIImageView!
    
    @IBOutlet weak var subcategoryName: UILabel!
    
    
    
    override func awakeFromNib() {
        subcategoryImage.layer.cornerRadius = 12
        subcategoryImage.clipsToBounds = true
        subcategoryImage.layer.borderWidth = 1
        subcategoryImage.layer.borderColor = UIColor.black.cgColor
    }
    
}
