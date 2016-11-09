//
//  ShareView.swift
//  JNews
//
//  Created by ChenKaijie on 16/8/18.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

protocol ShareViewDelegate {
    func shareViewButtonCallBack(type: ShareType)
}

class ShareView: UIView, CAAnimationDelegate {
    var sinaButton: UIButton?
    var timeLineButton: UIButton?
    var appMessageButton: UIButton?
    var delegate: ShareViewDelegate?
    
    init() {
        super.init(frame: CurrentWindow.frame)
        self.backgroundColor = UIColor.clearColor()
        
        sinaButton = UIButton()
        timeLineButton = UIButton()
        appMessageButton = UIButton()
        self.addSubview(sinaButton!)
        self.addSubview(timeLineButton!)
        self.addSubview(appMessageButton!)
        
        configuration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuration() {
        let padding = (WIDTH - 70*3)/4.0
        
        // WeChat TimeLine Button
        timeLineButton?.frame = CGRectMake(self.center.x - 35, HEIGHT, 70, 70)
        timeLineButton?.layer.cornerRadius = 35.0
        timeLineButton?.layer.masksToBounds = true
        timeLineButton?.setImage(UIImage(named:"TimeLineButton"), forState: .Normal)
        timeLineButton?.addTarget(self, action: .timeLineAction, forControlEvents: .TouchUpInside)
        
        // Sina Button
        sinaButton?.frame = CGRectMake(self.center.x - padding - 105, HEIGHT, 70, 70)
        sinaButton?.layer.cornerRadius = 35.0
        sinaButton?.layer.masksToBounds = true
        sinaButton?.setImage(UIImage(named:"SinaButton"), forState: .Normal)
        sinaButton?.addTarget(self, action: .sinaAction, forControlEvents: .TouchUpInside)
        
        // WeChat AppMessage Button
        appMessageButton?.frame = CGRectMake(self.center.x + padding + 35, HEIGHT, 70, 70)
        appMessageButton?.layer.cornerRadius = 35.0
        appMessageButton?.layer.masksToBounds = true
        appMessageButton?.setImage(UIImage(named:"WeChatButton"), forState: .Normal)
        appMessageButton?.addTarget(self, action: .appMessageAction, forControlEvents: .TouchUpInside)
        
        // BlackView
        let gesture = UITapGestureRecognizer(target: self, action: .dismissTapped)
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(gesture)
    }
    
    //MARK: - Animation Delegate
    func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.removeFromSuperview()
        blackView.removeFromSuperview()
    }
    
    //MARK: - UIButton Response
    func timeLineButtonClick(sender: UIButton) {
        guard delegate != nil else { return }
        delegate?.shareViewButtonCallBack(ShareType.WeChatTimeLine)
        self.removeFromSuperview()
        blackView.removeFromSuperview()
    }
    
    func sinaButtonClick(sender: UIButton) {
        guard delegate != nil else { return }
        delegate?.shareViewButtonCallBack(ShareType.Sina)
        self.removeFromSuperview()
        blackView.removeFromSuperview()
    }
    
    func appMessageButtonClick(sender: UIButton) {
        guard delegate != nil else { return }
        delegate?.shareViewButtonCallBack(ShareType.WeChatAppMessage)
        self.removeFromSuperview()
        blackView.removeFromSuperview()
    }
    
    //MARK: - Custom Method
    func show() {
        CurrentWindow.addSubview(blackView)
        CurrentWindow.addSubview(self)
        
        // Execute Animation
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 12.0, options: .AllowUserInteraction, animations: {
            self.timeLineButton?.frame.origin.y = self.center.y - 85
            self.blackView.alpha = 0.4
            }) { (true) in
                self.blackView.alpha = 0.4
                self.timeLineButton?.frame.origin.y = self.center.y - 85
        }
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 8.0, options: .AllowUserInteraction, animations: {
            self.sinaButton?.frame.origin.y = self.center.y - 85
            self.appMessageButton?.frame.origin.y = self.center.y - 85
        }) { (true) in
            self.sinaButton?.frame.origin.y = self.center.y - 85
            self.appMessageButton?.frame.origin.y = self.center.y - 85
        }
    }
    
    func dismiss() {
        // Execute Animation
        let centerAnimation = CAKeyframeAnimation()
        centerAnimation.keyPath = "transform.translation.y"
        centerAnimation.keyTimes = [NSNumber(float: 0.3), NSNumber(float: 1.0)]
        centerAnimation.values = [NSNumber(float: Float(-90)), NSNumber(float: Float(HEIGHT))]
        centerAnimation.delegate = self
        centerAnimation.duration = 0.6
        centerAnimation.repeatCount = 1.0
        centerAnimation.removedOnCompletion = false
        centerAnimation.fillMode = kCAFillModeForwards
        
        let leftOrRightAnimation = CAKeyframeAnimation()
        leftOrRightAnimation.keyPath = "transform.translation.y"
        leftOrRightAnimation.keyTimes = [NSNumber(float: 0.5), NSNumber(float: 1.0)]
        leftOrRightAnimation.values = [NSNumber(float: Float(-70)), NSNumber(float: Float(HEIGHT))]
        leftOrRightAnimation.duration = 0.6
        leftOrRightAnimation.repeatCount = 1.0
        leftOrRightAnimation.removedOnCompletion = false
        leftOrRightAnimation.fillMode = kCAFillModeForwards
        
        timeLineButton?.layer.addAnimation(centerAnimation, forKey: "Center")
        sinaButton?.layer.addAnimation(leftOrRightAnimation, forKey: "Left")
        appMessageButton?.layer.addAnimation(leftOrRightAnimation, forKey: "Right")
    }
    
    //MARK: - Getter
    private let blackView: UIView = {
        let coverView = UIView(frame: CurrentWindow.frame)
        coverView.backgroundColor = UIColor.blackColor()
        coverView.alpha = 0
        return coverView
    }()
}

//MARK: - Selector Extension
private extension Selector {
    static let dismissTapped = #selector(ShareView.dismiss)
    static let timeLineAction = #selector(ShareView.timeLineButtonClick(_:))
    static let sinaAction = #selector(ShareView.sinaButtonClick(_:))
    static let appMessageAction = #selector(ShareView.appMessageButtonClick(_:))
}
