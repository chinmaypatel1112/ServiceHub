//
//  TableViewCell.swift
//  ServiceHub
//
//  Created by Akash Padhiyar on 3/11/18.
//  Copyright © 2018 Chinmay Patel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
