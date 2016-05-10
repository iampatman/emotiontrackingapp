//
//  SecondOneCell.swift
//  EmotionTracking
//
//  Created by 周桠媚 on 10/05/16.
//  Copyright © 2016年 NguyenTrung. All rights reserved.
//

import UIKit

class SecondOneCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var thoughtLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
