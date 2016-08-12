//
//  DetailTopTableViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/12.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class DetailTopTableViewCell: UITableViewCell {
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var type: UILabel!
    var contentImageView: UIImageView!
    
    var index: NSInteger!
    var dataModel: NewsModel {
        get{
            return self.dataModel
        }
        set(newDataModel){
            var color = UIColor.clearColor()
            switch newDataModel.newsType!.intValue {
            case 0:
                type.text = "头条"
                color = TopLineColor
            case 1:
                type.text = "娱乐"
                color = EntertainmentColor
            case 2:
                type.text = "体育"
                color = SportsColor
            case 3:
                type.text = "科技"
                color = TechnologyColor
            case 4:
                type.text = "政治"
                color = PoliticsColor
            case 5:
                type.text = "社会"
                color = SocietyColor
            case 6:
                type.text = "健康"
                color = HealthColor
            case 7:
                type.text = "国际"
                color = InternationalColor
            default:
                return
            }
            type.textColor = color
            number.text = "\(index+1)"
            number.textColor = UIColor.whiteColor()
            numberView.backgroundColor = color
            contentImageView.sd_setImageWithURL(NSURL(string: newDataModel.newsPicture!), placeholderImage: UIImage(named: "scrollView1"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberView.layer.cornerRadius = 13.0
        numberView.layer.masksToBounds = true
        contentImageView = UIImageView.init(frame: imageScrollView.frame)
        imageScrollView.addSubview(contentImageView)

        // ImageView Setting
        contentImageView.clipsToBounds = true
        contentImageView.contentMode = .ScaleAspectFill
        contentImageView.autoresizingMask = .FlexibleHeight
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
