//
//  CustomArticleCell.swift
//  weGLOTogether
//
//  Created by Kamryn Ohly on 9/19/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit

class CustomArticleCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleLeadingPara: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
