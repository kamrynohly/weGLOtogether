//
//  CustomBusinessCell.swift
//  weGLOTogether
//
//  Created by Kamryn Ohly on 9/19/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit

class CustomBusinessCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var businessTitle: UILabel!
    @IBOutlet weak var businessPrice: UILabel!
    @IBOutlet weak var businessNumber: UILabel!
    @IBOutlet weak var businessAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

