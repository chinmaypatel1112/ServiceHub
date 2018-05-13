//
//  LocationTableViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 4/23/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblLocationList: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
