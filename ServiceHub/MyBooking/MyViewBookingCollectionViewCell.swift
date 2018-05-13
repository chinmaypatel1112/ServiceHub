//
//  MyViewBookingCollectionViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 4/26/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class MyViewBookingCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var SubcatName: UILabel!
    @IBOutlet weak var SubcatImage: UIImageView!
    @IBOutlet weak var BookingDate: UILabel!
    @IBOutlet weak var BookingTime: UILabel!
    @IBOutlet weak var WorkerName: UILabel!
    @IBOutlet weak var WorkerImage: UIImageView!
    @IBOutlet weak var BookingAddress: UILabel!
    @IBOutlet weak var BookingAmount: UILabel!
    @IBOutlet weak var BookingStatus: UILabel!
    

    override func awakeFromNib() {
        SubcatImage.layer.cornerRadius = 12
        SubcatImage.clipsToBounds = true
        SubcatImage.layer.borderWidth = 1
        SubcatImage.layer.borderColor = UIColor.black.cgColor
        
        WorkerImage.layer.cornerRadius = WorkerImage.frame.size.width / 2
        WorkerImage.clipsToBounds = true
        WorkerImage.layer.borderWidth = 1
        WorkerImage.layer.borderColor = UIColor.black.cgColor
        
    }
    
}
