//
//  AllSubcategoyTableViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/31/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class AllSubcategoyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var AllSubcategory_Image: UIImageView!
    
    @IBOutlet weak var AllSubcategory_Name: UILabel!
    
    
    override func awakeFromNib() {
        AllSubcategory_Image.layer.cornerRadius = 12
        AllSubcategory_Image.clipsToBounds = true
        AllSubcategory_Image.layer.borderWidth = 1
        AllSubcategory_Image.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
