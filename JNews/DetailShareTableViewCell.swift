//
//  DetailShareTableViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/8/18.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

protocol DetailShareTableViewCellDelegate {
    func shareCellButtonCallBack()
}

class DetailShareTableViewCell: UITableViewCell {
    @IBOutlet weak var shareTitle: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    var delegate: DetailShareTableViewCellDelegate?
    
    var newsType: NSInteger {
        get {
            return 0
        }
        set(newValue) {
            var color: UIColor = UIColor.clearColor()
            switch newValue {
            case 0:
                color = TopLineColor
            case 1:
                color = EntertainmentColor
            case 2:
                color = SportsColor
            case 3:
                color = TechnologyColor
            case 4:
                color = PoliticsColor
            case 5:
                color = SocietyColor
            case 6:
                color = HealthColor
            case 7:
                color = InternationalColor
            default:
                return
            }
            // Assign
            shareButton.backgroundColor = color
            shareButton.layer.borderColor = color.CGColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shareButton.layer.borderWidth = 1
        shareButton.layer.cornerRadius = 18.0
        shareButton.layer.masksToBounds = true
    }
    
    @IBAction func shareButtonAction(sender: UIButton) {
        guard delegate != nil else {
            print("你特么没代理啊!")
            return
        }
        delegate?.shareCellButtonCallBack()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
