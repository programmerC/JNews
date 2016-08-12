//
//  MainTableViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/11.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    var indexPath: NSIndexPath!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var commentNum: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var numberView: UIView!
    // 赋值
    var isRead: Bool = false
    var color: UIColor = UIColor.clearColor()
    var model: NewsModel {
        get{
            return self.model
        }
        set(newsModel){
            
            switch newsModel.newsType!.intValue {
            case 0:
                type.text = "头条"
                color = TopLineColor
                self.selectedBackgroundView?.backgroundColor = TopLineSelectedColor
            case 1:
                type.text = "娱乐"
                color = EntertainmentColor
                self.selectedBackgroundView?.backgroundColor = EntertainmentSelectedColor
            case 2:
                type.text = "体育"
                color = SportsColor
                self.selectedBackgroundView?.backgroundColor = SportsSelectedColor
            case 3:
                type.text = "科技"
                color = TechnologyColor
                self.selectedBackgroundView?.backgroundColor = TechnologySelectedColor
            case 4:
                type.text = "政治"
                color = PoliticsColor
                self.selectedBackgroundView?.backgroundColor = PoliticsSelectedColor
            case 5:
                type.text = "社会"
                color = SocietyColor
                self.selectedBackgroundView?.backgroundColor = SocietySelectedColor
            case 6:
                type.text = "健康"
                color = HealthColor
                self.selectedBackgroundView?.backgroundColor = HealthSelectedColor
            case 7:
                type.text = "国际"
                color = InternationalColor
                self.selectedBackgroundView?.backgroundColor = InternationalSelectedColor
            default:
                return
            }
            title.text = newsModel.newsTitle!
            number.text = "\(indexPath.row + 1)"
            commentNum.text = "\(newsModel.commNum!.intValue)跟帖"
            
            // Color Setting
            type.textColor = color
            if newsModel.isRead!.intValue == 0 {
                isRead = false
                number.textColor = color
                numberView.layer.borderWidth = 1.0
                numberView.layer.borderColor = color.CGColor
                numberView.backgroundColor = UIColor.clearColor()
            }
            else {
                isRead = true
                number.textColor = UIColor.whiteColor()
                numberView.backgroundColor = color
            }
        }
    }
    
    //MARK: - 分割线
    override func awakeFromNib() {
        super.awakeFromNib()
        numberView.layer.cornerRadius = 11.0
        numberView.layer.masksToBounds = true
        self.selectedBackgroundView = UIView.init(frame: self.frame)
    }
    
    //MARK: - Animation Start
    func animationStart() {
        guard !self.isRead else {
            return
        }
        UIView.animateWithDuration(0.8, animations: {
            self.number.textColor = UIColor.whiteColor()
            self.numberView.backgroundColor = self.color
            self.numberView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }) { (true) in
            self.numberView.transform = CGAffineTransformIdentity
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
