//
//  BottomCollectionViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/27.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        title.layer.borderWidth = 1.0
        title.layer.borderColor = UIColor.RGBColor(169, green: 169, blue: 169, alpha: 1).CGColor
        title.layer.cornerRadius = 25.0/2
        title.layer.masksToBounds = true
    }

}
