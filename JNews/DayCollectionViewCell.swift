//
//  DayCollectionViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/25.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
