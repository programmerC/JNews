//
//  LoadingView.swift
//  JNews
//
//  Created by ChenKaijie on 16/8/4.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    let radius: CGFloat = 45/2.0 - 4.5   // (总半径 - 圆圈半径) 用来计算每一个点的center
    var loadLayer = CALayer()   // Loading Layer
    // Color
    let firstColor = UIColor.RGBColor(0, green: 176, blue: 56, alpha: 1)
    let secondColor = UIColor.RGBColor(255, green: 182, blue: 63, alpha: 1)
    let thirdColor = UIColor.RGBColor(0, green: 140, blue: 212, alpha: 1)
    let fourthColor = UIColor.RGBColor(0, green: 167, blue: 141, alpha: 1)
    let fifthColor = UIColor.RGBColor(255, green: 0, blue: 123, alpha: 1)
    let sixthColor = UIColor.RGBColor(255, green: 87, blue: 36, alpha: 1)
    let endColor = UIColor.RGBColor(0, green: 140, blue: 212, alpha: 1)
    
    // Color Layer
    var firstLayer = CALayer()  // redColor
    var secondLayer = CALayer() // greenColor
    var thirdLayer = CALayer()  // yellowColor
    var fourthLayer = CALayer() // blackColor
    var fifthLayer = CALayer()  // blueColor
    var sixthLayer = CALayer()  // brownColor
    // Postion
    var firstPostion = CGPointZero
    var secondPostion = CGPointZero
    var thirdPostion = CGPointZero
    var fourthPostion = CGPointZero
    var fifthPostion = CGPointZero
    var sixthPostion = CGPointZero
    // Animation
    var rotateAnimation = CABasicAnimation()
    var firstGroupAnimation = CAAnimationGroup()
    var secondGroupAnimation = CAAnimationGroup()
    var thirdGroupAnimation = CAAnimationGroup()
    var fourthGroupAnimation = CAAnimationGroup()
    var fifthGroupAnimation = CAAnimationGroup()
    var sixthGroupAnimation = CAAnimationGroup()
    init() {
        // 位于正中心
        super.init(frame: CurrentWindow.frame)
        self.backgroundColor = UIColor.whiteColor()
        
        // Background Image
        let imageView = UIImageView(frame: self.frame)
        imageView.image = UIImage(named: "")
        self.addSubview(imageView)
        
        configurateLayer()
        configurateAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Configurate Layer
    func configurateLayer() {
        loadLayer.frame = CGRectMake(self.center.x - 45, self.center.y - 45, 90, 90)
        loadLayer.backgroundColor = UIColor.clearColor().CGColor
        loadLayer.position = self.center
        
        let centerX: CGFloat = 45
        let centerY: CGFloat = 45
        // 这里计算center，每一个相隔60°，所以计算sin和cos然后算出位置即可
        firstPostion = CGPointMake(centerX, centerY - radius)
        secondPostion = CGPointMake(centerX + radius*sin(CGFloat(M_PI)/3.0), centerY - radius*cos(CGFloat(M_PI/3.0)))
        thirdPostion = CGPointMake(centerX + radius*cos(CGFloat(M_PI)/6.0), centerY + radius*sin(CGFloat(M_PI/6.0)))
        fourthPostion = CGPointMake(centerX, centerY + radius)
        fifthPostion = CGPointMake(centerX - radius*sin(CGFloat(M_PI)/3.0), centerY + radius*cos(CGFloat(M_PI/3.0)))
        sixthPostion = CGPointMake(centerX - radius*sin(CGFloat(M_PI)/3.0), centerY - radius*cos(CGFloat(M_PI/3.0)))
        
        // Add Six Circles
        firstLayer.frame = CGRectMake(0, 0, 9, 9)
        firstLayer.position = firstPostion
        firstLayer.cornerRadius = 4.5
        firstLayer.masksToBounds = true
        firstLayer.backgroundColor = firstColor.CGColor
        loadLayer.addSublayer(firstLayer)
        
        secondLayer.frame = CGRectMake(0, 0, 9, 9)
        secondLayer.position = secondPostion
        secondLayer.cornerRadius = 4.5
        secondLayer.masksToBounds = true
        secondLayer.backgroundColor = secondColor.CGColor

        loadLayer.addSublayer(secondLayer)
        
        thirdLayer.frame = CGRectMake(0, 0, 9, 9)
        thirdLayer.position = thirdPostion
        thirdLayer.cornerRadius = 4.5
        thirdLayer.masksToBounds = true
        thirdLayer.backgroundColor = thirdColor.CGColor

        loadLayer.addSublayer(thirdLayer)
        
        fourthLayer.frame = CGRectMake(0, 0, 9, 9)
        fourthLayer.position = fourthPostion
        fourthLayer.cornerRadius = 4.5
        fourthLayer.masksToBounds = true
        fourthLayer.backgroundColor = fourthColor.CGColor
        loadLayer.addSublayer(fourthLayer)
        
        fifthLayer.frame = CGRectMake(0, 0, 9, 9)
        fifthLayer.position = fifthPostion
        fifthLayer.cornerRadius = 4.5
        fifthLayer.masksToBounds = true
        fifthLayer.backgroundColor = fifthColor.CGColor
        loadLayer.addSublayer(fifthLayer)
        
        sixthLayer.frame = CGRectMake(0, 0, 9, 9)
        sixthLayer.position = sixthPostion
        sixthLayer.cornerRadius = 4.5
        sixthLayer.masksToBounds = true
        sixthLayer.backgroundColor = sixthColor.CGColor
        loadLayer.addSublayer(sixthLayer)
        
        self.layer.addSublayer(loadLayer)
    }
    
    //MARK: - Configurate Animation
    func configurateAnimation() {
        rotateAnimation = CABasicAnimation()
        rotateAnimation.keyPath = "transform.rotation"
        rotateAnimation.fromValue = NSNumber.init(float: 0)
        rotateAnimation.toValue = NSNumber.init(float: 2*Float(M_PI))
        rotateAnimation.duration = 1.2
        rotateAnimation.repeatCount = Float.infinity    // 无限循环
        rotateAnimation.removedOnCompletion = false     // 动画后不移除
        rotateAnimation.fillMode = kCAFillModeForwards  // 保留动画后的样子，如果removedOnCompletion不是false,没效果
        
        // Scale
        let sizeAnimation = CAKeyframeAnimation()
        sizeAnimation.keyPath = "transform.scale"
        sizeAnimation.keyTimes = [NSNumber(float: 0), NSNumber(float: 0.2), NSNumber(float: 0.4), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        sizeAnimation.values = [NSNumber(float: 1.0), NSNumber(float: 0.8), NSNumber(float: 0.8), NSNumber(float: 1.4), NSNumber(float: 1.6)]
        sizeAnimation.duration = 1.6
        sizeAnimation.repeatCount = 1.0
        
        // Color
        let colorAnimation = CAKeyframeAnimation()
        colorAnimation.keyPath = "backgroundColor"
        colorAnimation.keyTimes = [NSNumber(float: 0.6), NSNumber(float: 1.0)]
        colorAnimation.values = [endColor.CGColor, endColor.CGColor]
        colorAnimation.duration = 1.6
        colorAnimation.repeatCount = 1.0
        
        // First Animation Group
        firstGroupAnimation = CAAnimationGroup()
        firstGroupAnimation.duration = 1.6
        firstGroupAnimation.repeatCount = 1.0
        
        let firstTransformAnimation = CAKeyframeAnimation()
        firstTransformAnimation.keyPath = "position"
        firstTransformAnimation.keyTimes = [NSNumber(float: 0.2), NSNumber(float: 0.4), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        let firstPoint1 = CGPointMake(45, 17)
        let firstPoint2 = CGPointMake(45, 45)
        firstTransformAnimation.values = [NSValue(CGPoint: firstPoint1), NSValue(CGPoint: firstPoint1), NSValue(CGPoint: firstPoint2), NSValue(CGPoint: firstPoint2)]
        firstTransformAnimation.duration = 1.6
        firstTransformAnimation.repeatCount = 1.0
        firstGroupAnimation.animations = [colorAnimation, sizeAnimation, firstTransformAnimation]
        
        // Second Animation Group
        secondGroupAnimation = CAAnimationGroup()
        secondGroupAnimation.duration = 1.6
        secondGroupAnimation.repeatCount = 1.0
        
        let secondTransformAnimation = CAKeyframeAnimation()
        secondTransformAnimation.keyPath = "position"
        secondTransformAnimation.keyTimes = [NSNumber(float: 0.2), NSNumber(float: 0.4), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        let secondX = secondPostion.x + 10*cos(CGFloat(M_PI/6.0))
        let secondY = secondPostion.y - 10*sin(CGFloat(M_PI/6.0))
        
        let secondPoint1 = CGPointMake(secondX, secondY)
        let secondPoint2 = CGPointMake(45, 45)
        secondTransformAnimation.values = [NSValue(CGPoint: secondPoint1), NSValue(CGPoint: secondPoint1), NSValue(CGPoint: secondPoint2), NSValue(CGPoint: secondPoint2)]
        secondTransformAnimation.duration = 1.6
        secondTransformAnimation.repeatCount = 1.0
        secondGroupAnimation.animations = [colorAnimation, sizeAnimation, secondTransformAnimation]
        
        // Third Animation Group
        thirdGroupAnimation = CAAnimationGroup()
        thirdGroupAnimation.duration = 1.6
        thirdGroupAnimation.repeatCount = 1.0
        
        let thirdTransformAnimation = CAKeyframeAnimation()
        thirdTransformAnimation.keyPath = "position"
        thirdTransformAnimation.keyTimes = [NSNumber(float: 0.2), NSNumber(float: 0.4), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        let thirdX = thirdPostion.x + 10*cos(CGFloat(M_PI/6.0))
        let thirdY = thirdPostion.y + 10*sin(CGFloat(M_PI/6.0))
        
        let thirdPoint1 = CGPointMake(thirdX, thirdY)
        let thirdPoint2 = CGPointMake(45, 45)
        thirdTransformAnimation.values = [NSValue(CGPoint: thirdPoint1), NSValue(CGPoint: thirdPoint1), NSValue(CGPoint: thirdPoint2), NSValue(CGPoint: thirdPoint2)]
        thirdTransformAnimation.duration = 1.6
        thirdTransformAnimation.repeatCount = 1.0
        thirdGroupAnimation.animations = [colorAnimation, sizeAnimation, thirdTransformAnimation]
        
        // Fourth Animation Group
        fourthGroupAnimation = CAAnimationGroup()
        fourthGroupAnimation.duration = 1.6
        fourthGroupAnimation.repeatCount = 1.0
        
        let fourthTransformAnimation = CAKeyframeAnimation()
        fourthTransformAnimation.keyPath = "position"
        fourthTransformAnimation.keyTimes = [NSNumber(float: 0.2), NSNumber(float: 0.4), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        let fourthPoint1 = CGPointMake(45, 73)
        let fourthPoint2 = CGPointMake(45, 45)
        fourthTransformAnimation.values = [NSValue(CGPoint: fourthPoint1), NSValue(CGPoint: fourthPoint1), NSValue(CGPoint: fourthPoint2), NSValue(CGPoint: fourthPoint2)]
        fourthTransformAnimation.duration = 1.6
        fourthTransformAnimation.repeatCount = 1.0
        fourthGroupAnimation.animations = [colorAnimation, sizeAnimation, fourthTransformAnimation]
        
        // Fifth Animation Group
        fifthGroupAnimation = CAAnimationGroup()
        fifthGroupAnimation.duration = 1.6
        fifthGroupAnimation.repeatCount = 1.0
        
        let fifthTransformAnimation = CAKeyframeAnimation()
        fifthTransformAnimation.keyPath = "position"
        fifthTransformAnimation.keyTimes = [NSNumber(float: 0.2), NSNumber(float: 0.4), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        let fifthX = fifthPostion.x - 10*cos(CGFloat(M_PI/6.0))
        let fifthY = fifthPostion.y + 10*sin(CGFloat(M_PI/6.0))
        
        let fifthPoint1 = CGPointMake(fifthX, fifthY)
        let fifthPoint2 = CGPointMake(45, 45)
        fifthTransformAnimation.values = [NSValue(CGPoint: fifthPoint1), NSValue(CGPoint: fifthPoint1), NSValue(CGPoint: fifthPoint2), NSValue(CGPoint: fifthPoint2)]
        fifthTransformAnimation.duration = 1.6
        fifthTransformAnimation.repeatCount = 1.0
        fifthGroupAnimation.animations = [colorAnimation, sizeAnimation, fifthTransformAnimation]
        
        // Sixth Animation Group
        sixthGroupAnimation = CAAnimationGroup()
        sixthGroupAnimation.duration = 1.6
        sixthGroupAnimation.repeatCount = 1.0
        
        let sixthTransformAnimation = CAKeyframeAnimation()
        sixthTransformAnimation.keyPath = "position"
        sixthTransformAnimation.keyTimes = [NSNumber(float: 0.2), NSNumber(float: 0.4), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        let sixthX = sixthPostion.x - 10*cos(CGFloat(M_PI/6.0))
        let sixthY = sixthPostion.y - 10*sin(CGFloat(M_PI/6.0))
        
        let sixthPoint1 = CGPointMake(sixthX, sixthY)
        let sixthPoint2 = CGPointMake(45, 45)
        sixthTransformAnimation.values = [NSValue(CGPoint: sixthPoint1), NSValue(CGPoint: sixthPoint1), NSValue(CGPoint: sixthPoint2), NSValue(CGPoint: sixthPoint2)]
        sixthTransformAnimation.duration = 1.6
        sixthTransformAnimation.repeatCount = 1.0
        sixthGroupAnimation.animations = [colorAnimation, sizeAnimation, sixthTransformAnimation]
    }
    
    //MARK: - Show OR Dismiss
    func show() {
        CurrentWindow.addSubview(self)
        // 执行动画
        self.loadLayer.addAnimation(self.rotateAnimation, forKey: "Rotation")
    }
    
    func dismiss() {
        // 先停止转圈动画
        self.loadLayer.removeAnimationForKey("Rotation") //此方法停止后，图层外观会更新到当前模型的值
        // 执行结束动画
        self.firstLayer.addAnimation(self.firstGroupAnimation, forKey: "FirstCircle")
        self.secondLayer.addAnimation(self.secondGroupAnimation, forKey: "SecondCircle")
        self.thirdLayer.addAnimation(self.thirdGroupAnimation, forKey: "ThirdCircle")
        self.fourthLayer.addAnimation(self.fourthGroupAnimation, forKey: "FourthCircle")
        self.fifthLayer.addAnimation(self.fifthGroupAnimation, forKey: "FifthCircle")
        self.sixthLayer.addAnimation(self.sixthGroupAnimation, forKey: "SixthCircle")
        Delay(1.4) {
            self.exchangeViews()
        }
    }
    
    /*
     CAShapeLayer 是一个通过矢量图形而不是bitmap来绘制的图层子类
     不需要创建寄宿图形，高效使用内存，硬件加速渲染，可以根据CGPath绘制各种形状的图形(不需要闭合)
     */
    func exchangeViews() {
        let rootView = CurrentWindow.subviews[0]
        let fromPath = UIBezierPath(arcCenter: self.center, radius: 7.2, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true);
        let toPath = UIBezierPath.init(arcCenter: self.center, radius: HEIGHT, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
        
        let maskLayer = CAShapeLayer();
        maskLayer.path = fromPath.CGPath;
        rootView.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = fromPath.CGPath
        maskLayerAnimation.toValue = toPath.CGPath
        maskLayerAnimation.duration = 0.8
        maskLayerAnimation.delegate = self
        maskLayerAnimation.removedOnCompletion = false
        maskLayerAnimation.fillMode = kCAFillModeForwards
        maskLayer.addAnimation(maskLayerAnimation, forKey: "MaskPath")
        
        CurrentWindow.exchangeSubviewAtIndex(0, withSubviewAtIndex: 1)
    }
    
    //MARK: - Animation Stop
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.loadLayer.removeFromSuperlayer()
        self.removeFromSuperview()
    }
}
