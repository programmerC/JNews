//
//  NewsNumberTipsView.swift
//  JNews
//
//  Created by ChenKaijie on 16/8/19.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class NewsNumberTipsView: UIView {
    init(currentNumber: NSInteger, totalNumber: NSInteger, frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, 50, 25))
        imageView.image = UIImage.drawImage(CGRectMake(0, 0, 50, 25), cornerRadius: 5.0, color: UIColor.blackColor())
        imageView.alpha = 0.7
        self.addSubview(imageView)
        
        let label = UILabel.init(frame: CGRectMake(0, 0, 50, 25))
        label.text = "\(currentNumber)/\(totalNumber)"
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
