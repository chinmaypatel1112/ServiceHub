//
//  WorkerListingCollectionViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/23/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class WorkerListingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var worker_photo: UIImageView!
    @IBOutlet weak var worker_name: UILabel!
    @IBOutlet weak var worker_charges: UILabel!
    
    
    override func awakeFromNib() {
        worker_photo.layer.cornerRadius = 12
        worker_photo.clipsToBounds = true
        worker_photo.layer.borderWidth = 1
        worker_photo.layer.borderColor = UIColor.black.cgColor
    }
    
}
