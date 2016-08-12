//
//  CountdownView.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/21.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

protocol CountdownViewDelegate {
    func animationStopCallBack(callBackInterval: NSTimeInterval, callBackReverseInterval: NSTimeInterval)
}

class CountdownView: UIView {
    let defaultFrame = CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 115)
    var defaultCircleRadius: CGFloat = 110.0
    let circleLayer = CAShapeLayer()
    let circleShadowLayer = CAShapeLayer()
    
    var reverseInterval: NSTimeInterval?
    var interval: NSTimeInterval?
    var timeLabel: UILabel?
    var type: TimeType?
    // Delegate
    var delegate: CountdownViewDelegate?
    
    
    init(timeType: TimeType) {
        super.init(frame: defaultFrame)
        type = timeType
        self.backgroundColor = UIColor.clearColor()
        
        // NSTimeInterval 初始化
        interval = setInterval()
        
        // CAShaperLayer Setting
        circleShadowLayer.frame = self.bounds
        circleShadowLayer.fillColor = UIColor.clearColor().CGColor
        circleShadowLayer.lineWidth = 2.0
        circleShadowLayer.strokeEnd = 1.0
        circleShadowLayer.strokeColor = UIColor.RGBColor(255, green: 255, blue: 255, alpha: 0.2).CGColor
        
        circleLayer.frame = self.bounds
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.lineWidth = 2.0
        circleLayer.strokeEnd = 0
        circleLayer.strokeColor = UIColor.RGBColor(0, green: 121, blue: 166, alpha: 1).CGColor
        
        self.layer.addSublayer(circleShadowLayer)
        self.layer.addSublayer(circleLayer)
        
        timeLabel = UILabel.init(frame: CGRectMake(0, 0, WIDTH, 30))
        
        let hour = Int(reverseInterval!/3600)
        let minute = Int(reverseInterval!%3600/60)
        let seconds = Int(reverseInterval!%60)
        let timeString = String.init(format: "%.2d%.2d%.2d", hour, minute, seconds)
        assert(timeString.characters.count == 6, "text转换位数出错:\(timeString)")
        timeLabel?.setLabelText(timeString, duration: 1.6, delay:0.3, attributed: fontStyleArray())

        timeLabel?.textAlignment = NSTextAlignment.Center
        self.addSubview(timeLabel!)
        
        timeLabel?.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        defaultCircleRadius = (WIDTH - 100) < (self.bounds.height - 32) ? (WIDTH - 100)/2.0 : defaultCircleRadius
        circleShadowLayer.frame = self.bounds
        circleShadowLayer.path = circlePath().CGPath
        circleLayer.frame = self.bounds
        circleLayer.path = circlePath().CGPath
    }
    
    //MARK: - CirclePath
    func circlePath() -> UIBezierPath {
        return UIBezierPath.init(ovalInRect: circleFrame())
    }
    
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*defaultCircleRadius, height: 2*defaultCircleRadius)
        circleFrame.origin.x = CGRectGetMidX(circleShadowLayer.bounds) - CGRectGetMidX(circleFrame)
        circleFrame.origin.y = CGRectGetMidY(circleShadowLayer.bounds) - CGRectGetMidY(circleFrame)
        return circleFrame
    }
    
    //MARK: - Animation
    func setInterval() -> NSTimeInterval{
        if type == TimeType.Day {
            // Day
            guard String.getCurrentTimeString().compare(String.getEndTimeString()) == NSComparisonResult.OrderedAscending else {
                return 0
            }
            // Reverse Interval
            reverseInterval = String.getInterval(String.getCurrentTimeString(), end: String.getEndTimeString()) - 2
            // Return Interval
            return String.getInterval(String.getStartTimeString(), end: String.getCurrentTimeString()) + 2
        }
        else {
            // Night
            if String.getCurrentTimeString().compare(String.getStartTimeString()) == NSComparisonResult.OrderedAscending {
                // 00:00 - 06:00
                
                // Reverse Interval
                reverseInterval = String.getInterval(String.getCurrentTimeString(), end: String.getStartTimeString()) - 2
                return String.getInterval(String.getYesterdayEndTimeString(NSDate()), end: String.getCurrentTimeString()) + 2
            }
            else {
                // 18:00 - 00:00
                
                // Reverse Interval
                reverseInterval = String.getInterval(String.getCurrentTimeString(), end: String.getTomorrowStartTimeString(NSDate())) - 2
                return String.getInterval(String.getEndTimeString(), end: String.getCurrentTimeString()) + 2
            }
        }
    }
    
    func animationExecute() {
        circleLayer.addAnimation(self.circleAnimationImplement(1.6, delay: 0.3, toValue: interval!/43200.0), forKey: nil)
        
        /*
         *   UIView.animateWithDuration(13.2, animations: {
         *       self.circleLayer.strokeEnd = CGFloat(interval/43200)
         *   })
         *   这里执行方式不可以使用UIView.animateWithDuration，只能用CAAnimations
         *   UIView动画执行只能改变一下几个参数
         *
         *   The following properties of the UIView class are animatable:
         *   @property frame
         *   @property bounds
         *   @property center
         *   @property transform
         *   @property alpha
         *   @property backgroundColor
         *   @property contentStretch
         */
    }
    
    // Animation Implement
    private func circleAnimationImplement(duration: NSTimeInterval, delay: Double, toValue: Double) -> CABasicAnimation {
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = duration < 0.8 ? 0.8 : duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.fromValue = 0.0
        animation.toValue = toValue
        animation.removedOnCompletion = false // 这里如果不是false fillMode属性不起作用
        animation.fillMode = kCAFillModeForwards; // 保留动画后的样子
        // 设置Delegate
        animation.delegate = self
        return animation
    }
    
    // Animation Delegate
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if delegate != nil && flag{
            delegate?.animationStopCallBack(self.interval!, callBackReverseInterval: self.reverseInterval!)
        }
        else {
            print("你特么没设代理啊！")
        }
    }
    
    //MARK: - NSMutableAttributedString
    func fontStyleArray() -> NSArray {
        let color = type == TimeType.Day ? DayColor : NightColor
        
        let firstAttr = self.attDictionary([NSForegroundColorAttributeName:color, NSFontAttributeName:UIFont.systemFontOfSize(24)], range: NSMakeRange(0, 2))
        let secondAttr = self.attDictionary([NSForegroundColorAttributeName:color, NSFontAttributeName:UIFont.systemFontOfSize(12)], range: NSMakeRange(2, 1))
        let thirdAttr = self.attDictionary([NSForegroundColorAttributeName:color, NSFontAttributeName:UIFont.systemFontOfSize(24)], range: NSMakeRange(4, 2))
        let fourthAttr = self.attDictionary([NSForegroundColorAttributeName:color, NSFontAttributeName:UIFont.systemFontOfSize(12)], range: NSMakeRange(6, 1))
        let fifthAttr = self.attDictionary([NSForegroundColorAttributeName:color, NSFontAttributeName:UIFont.systemFontOfSize(24)], range: NSMakeRange(8, 2))
        let sixthAttr = self.attDictionary([NSForegroundColorAttributeName:color, NSFontAttributeName:UIFont.systemFontOfSize(12)], range: NSMakeRange(10, 1))
        return NSArray.init(objects: firstAttr, secondAttr, thirdAttr, fourthAttr, fifthAttr, sixthAttr)
    }
    
    func attDictionary(attribute: NSDictionary, range: NSRange) -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setObject(attribute , forKey: "attributeValue")
        let rangeValue = NSValue(range: range)
        dictionary.setObject(rangeValue, forKey: "rangeValue")
        return dictionary
    }
}
