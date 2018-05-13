//
//  SubCatCollectionViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/21/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class SubCatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subCat_image: UIImageView!
    
    @IBOutlet weak var subCat_name: UILabel!
    
    
    override func awakeFromNib() {
        subCat_image.layer.cornerRadius = 12
        subCat_image.clipsToBounds = true
        subCat_image.layer.borderWidth = 1
        subCat_image.layer.borderColor = UIColor.black.cgColor
    
    }
    
}
