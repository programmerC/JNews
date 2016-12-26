//
//  MainTopTableViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/11.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class MainTopTableViewCell: UITableViewCell {
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var commentNum: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var selectedView: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    // 赋值
    var isRead: Bool = false
    var color: UIColor = UIColor.clearColor()
    var model: NewsModel {
        get{
            return self.model
        }
        set(newsModel){
            // Context Height
            let context = newsModel.newsTitle!
            let height = context.getHeight(context, margin: 65, fontSize: 17)
            heightConstraint.constant = (height < 21) ? 149 : 149 - 21 + height;
            print("newsType: \(newsModel.newsType)")
            switch newsModel.newsType!.intValue {
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
            title.text = context
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
        setUpTime()
        numberView.layer.cornerRadius = 11.0
        numberView.layer.masksToBounds = true
        
        // Add TapGesture
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(MainTopTableViewCell.tapHandle(_:)))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        backgroundImage.addGestureRecognizer(gesture)
    }
    
    // 初始化时间
    func setUpTime() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM.dd HH:mm"
        
        let tempDate = NSDate()
        let timeArray = dateFormatter.stringFromDate(tempDate).componentsSeparatedByString(" ")
        // Current Date
        currentDate.text = timeArray[0]
        // Weeks
        let days = Int(tempDate.timeIntervalSince1970/86400)
        let weeks = (days - 3)%7 // 0-6表示周日到周六
        switch weeks {
        case 0:
            currentTime.text = "星期日 \(timeArray[1])"
        case 1:
            currentTime.text = "星期一 \(timeArray[1])"
        case 2:
            currentTime.text = "星期二 \(timeArray[1])"
        case 3:
            currentTime.text = "星期三 \(timeArray[1])"
        case 4:
            currentTime.text = "星期四 \(timeArray[1])"
        case 5:
            currentTime.text = "星期五 \(timeArray[1])"
        case 6:
            currentTime.text = "星期六 \(timeArray[1])"
        default:
            return;
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted == true {
            // 手指按下Cell的时候
            self.selectedView.hidden = false
        }
        else {
            // 手指离开Cell的时候
            self.selectedView.hidden = true
        }
    }
    
    func tapHandle(sender: UITapGestureRecognizer) {
        print("Nothing to Do")
        // 让imageView部分不可点击
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
