//
//  DetailTableViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/12.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    var dataModel: NewsModel {
        get{
            return self.dataModel
        }
        set(newDataModel){
            title.text = newDataModel.newsTitle!
            content.text = newDataModel.newsContent!
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
