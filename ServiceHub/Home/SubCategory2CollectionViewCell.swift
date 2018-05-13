//
//  SubCategory2CollectionViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/20/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class SubCategory2CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var subcategoryImage2: UIImageView!
    
    @IBOutlet weak var subcategoryName2: UILabel!
 
    
    override func awakeFromNib() {
        subcategoryImage2.layer.cornerRadius = 12
        subcategoryImage2.clipsToBounds = true
        subcategoryImage2.layer.borderWidth = 1
        subcategoryImage2.layer.borderColor = UIColor.black.cgColor
    }
    
}
