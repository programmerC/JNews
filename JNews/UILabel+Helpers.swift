//
//  UILabel+Helpers.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/23.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit
import Foundation

private var labelNumberKey : Void?
private var labelTimerKey : Void?
extension UILabel {
    public var labelNumber: NSNumber? {
        get {
            return objc_getAssociatedObject(self, &labelNumberKey) as? NSNumber
        }
    }
    
    private func setLabelNumber(number: NSNumber) {
        objc_setAssociatedObject(self, &labelNumberKey, number, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public var labelTimer: NSTimer? {
        get {
            return objc_getAssociatedObject(self, &labelTimerKey) as? NSTimer
        }
    }
    
    private func setLabelTimer(timer: NSTimer) {
        objc_setAssociatedObject(self, &labelTimerKey, timer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private let BeginNumber = "BeginNumber"
private let EndNumber = "EndNumber"
private let RangeNumber = "RangeNumber"
private let Attributes = "Attributes"
private let frequency = 1.0/30.0

extension UILabel {
    public func setLabelText(text: String, duration: NSTimeInterval, delay: NSTimeInterval, attributed: AnyObject?) {
        // 使之前的Timer失效
        self.labelTimer?.invalidate()
        
        // Duration 执行时间
        var durationTime: NSTimeInterval = duration < 0.8 ? 0.8 : duration
        
        // 初始化 labelNumber
        self.setLabelNumber(NSNumber.init(int: 0))
        
        let userDict: NSMutableDictionary = NSMutableDictionary()
        let beginNumber: NSNumber = 0
        userDict.setValue(beginNumber, forKey: BeginNumber)
        
        let tempNumber = NSInteger(text)
        guard (tempNumber != nil) else {
            return
        }
        let endNumber = Int64(tempNumber!)
        guard endNumber < INT64_MAX else {
            return
        }
        userDict.setValue(NSNumber.init(longLong: endNumber), forKey: EndNumber)
        
        // 如果每次增长少于数字少于1，减少执行时间
        if Double(endNumber)*frequency/durationTime < 1.0 {
            durationTime = durationTime*0.3
        }

        // 数字滚动每次增长的数目
        let rangeNumber = (Double(endNumber)*frequency)/durationTime
        userDict.setValue(NSNumber(double: rangeNumber), forKey: RangeNumber)
        
        if attributed != nil {
            userDict.setValue(attributed, forKey: Attributes)
        }
        // Delay 延时
        Delay(delay) { 
            self.setLabelTimer(NSTimer.scheduledTimerWithTimeInterval(frequency, target: self, selector: #selector(UILabel.labelAnimation(_:)), userInfo: userDict, repeats: true))
            // 滑动状态和普通状态都执行timer
            NSRunLoop.currentRunLoop().addTimer(self.labelTimer!, forMode: NSRunLoopCommonModes)
        }
    }
    
    public func labelAnimation(timer: NSTimer) {
        if timer.userInfo?.valueForKey(RangeNumber)?.floatValue >= 1.0 {
            let rangeInteger = timer.userInfo?.valueForKey(RangeNumber)?.longLongValue;
            let resultInteger = (self.labelNumber?.longLongValue)! + rangeInteger!;
            self.setLabelNumber(NSNumber(longLong: resultInteger))
        }
        else {
            let rangeInteger = timer.userInfo?.valueForKey(RangeNumber)?.floatValue;
            let resultInteger = (self.labelNumber?.floatValue)! + rangeInteger!;
            self.setLabelNumber(NSNumber(float: resultInteger))
        }
        
        // 设置 Text
        let numberText = String.init(format: "%.6d", self.labelNumber!.integerValue)
        assert(numberText.characters.count == 6, "LabelNumber转换位数出错:\(numberText)")
        
        let numberTextString = NSMutableString.init(string: numberText)
        numberTextString.insertString("h ", atIndex: 2)
        numberTextString.insertString("m ", atIndex: 6)
        numberTextString.insertString("s ", atIndex: 10)
        self.text = numberTextString as String
        
        // 设置 Attributes
        let attributes = timer.userInfo?.valueForKey(Attributes)
        if attributes != nil {
            self.drawAttributes(attributes!)
        }
        
        let endNumber : NSNumber = timer.userInfo?.valueForKey(EndNumber) as! NSNumber
        if self.labelNumber?.longLongValue >= endNumber.longLongValue {
            // 大于当前时间
            let resultNumber: NSNumber = timer.userInfo?.valueForKey(EndNumber) as! NSNumber
            let resultText = String.init(format: "%.6d", resultNumber.longLongValue)
            assert(resultText.characters.count == 6, "LabelNumber转换位数出错:\(numberText)")
            
            let resultTextString = NSMutableString.init(string: resultText)
            resultTextString.insertString("h ", atIndex: 2)
            resultTextString.insertString("m ", atIndex: 6)
            resultTextString.insertString("s ", atIndex: 10)
            self.text = resultTextString as String
            let attributes = timer.userInfo?.valueForKey(Attributes)
            if attributes != nil {
                self.drawAttributes(attributes!)
            }
            // 停止计时器
            self.labelTimer?.invalidate()
        }
    }
    
    public func drawAttributes(attributes: AnyObject) -> Void {
        if attributes.isKindOfClass(NSDictionary) {
            let range = attributes.valueForKey("rangeValue")?.rangeValue
            let attribute = attributes.valueForKey("attributeValue")
            self.addAttributes(attribute!, range : range!)
        } else if attributes.isKindOfClass(NSArray) {
            for attribute in attributes as! NSArray {
                let range = attribute.valueForKey("rangeValue")?.rangeValue
                let attri = attribute.valueForKey("attributeValue")
                self.addAttributes(attri!, range : range!)
            }
        }
    }
    
    private func addAttributes(attributes: AnyObject, range: NSRange) -> Void {
        let attributedStr = NSMutableAttributedString(attributedString : self.attributedText!)
        if range.location + range.length < attributedStr.length  {
            attributedStr.addAttributes(attributes as! [String : AnyObject], range: range)
        }
        self.attributedText = attributedStr;
    }
    
}