//
//  SpringView.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/28.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit
import SnapKit

class SpringView: UIView {
    var centerView: UIView?
    var bottomButton: UIButton?
    
    init(timeType: TimeType) {
        super.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
        if timeType == TimeType.Day {
            self.backgroundColor = UIColor.RGBColor(189, green: 189, blue: 189, alpha: 1)
        }
        else {
            self.backgroundColor = UIColor.blackColor()
        }
        
        centerView = UIView.init(frame: CGRectMake(15, HEIGHT, WIDTH - 30, 422*(WIDTH - 30)/(HEIGHT - 245)))
        centerView?.backgroundColor = UIColor.whiteColor()
        self.addSubview(centerView!)
        
        bottomButton = UIButton(frame: CGRectZero)
        bottomButton?.setImage(UIImage(named: "BackButton"), forState: .Normal)
        self.addSubview(bottomButton!)
        configuration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SpringView.tapHandle(_:)))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(gesture)
        
        bottomButton?.layer.borderWidth = 1
        bottomButton?.layer.borderColor = UIColor.whiteColor().CGColor
        bottomButton?.layer.cornerRadius = 14.0
        bottomButton?.layer.masksToBounds = true
        bottomButton?.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-16)
            make.centerX.equalTo(self)
            make.width.equalTo(28)
            make.height.equalTo(28)
        })
        bottomButton?.addTarget(self, action: #selector(SpringView.dismiss), forControlEvents: .TouchUpInside)
    }
    
    //MARK: - TapGesture
    func tapHandle(sender: UITapGestureRecognizer) {
        self.dismiss()
    }

    //MARK: - Custom Method
    func show() {
        CurrentWindow.addSubview(self)
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 8.0, options: .AllowUserInteraction, animations: {
            self.centerView?.frame.origin.y = 100
            }) { (true) in
                self.centerView?.frame.origin.y = 100
        }
        /*
         *   usingSpringWithDamping 参数从0.0-1.0,数值越小，弹簧效果越明显
         *   initialSpringVelocity 表示初始速度，数值越大一开始移动越快
         */
    }
    
    func dismiss() {
        self.centerView?.frame.origin.y = 100
        UIView.animateWithDuration(0.6, animations: {
            self.alpha = 0
            self.centerView?.frame.origin.y = HEIGHT
            }) { (true) in
                self.alpha = 0
                self.removeFromSuperview()
        }
    }
}
