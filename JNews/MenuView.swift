//
//  MenuView.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/21.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit
import SnapKit

protocol MenuViewDelegate {
    func menuViewCallBack()
}

let CurrentWindow: UIWindow! = UIApplication.sharedApplication().keyWindow;
class MenuView: UIView, CountdownViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    var type: TimeType?
    var selectedItem: NSIndexPath?
    var countDownView: CountdownView?
    var dateView: DatesCollectionView?
    // Date
    var dateArray: [Dictionary<String, String>]?
    // Countdown
    var timer: NSTimer?
    var interval: NSTimeInterval?
    var reverseInterval: NSTimeInterval?
    // Delegate
    var delegate: MenuViewDelegate?
    
    init(timeType: TimeType, selectedItem: NSIndexPath = NSIndexPath.init(forItem: 10, inSection: 10), date: NSDate = NSDate()) {
        super.init(frame: CGRectMake(0, 0, WIDTH, HEIGHT))
        alpha = 0
        backgroundColor = UIColor.clearColor()
        
        // Assign
        type = timeType
        self.selectedItem = selectedItem
        dateArray = String.getFiveDatesArray(date)
        
        // BackGround EffectView
        if timeType == TimeType.Day {
            addSubview(dayEffectView)
        }
        else {
            addSubview(nightEffectView)
        }
        // BackButton
        let button = UIButton.init(frame: CGRectMake(WIDTH - 58, 8, 50, 50))
        button.setImage(UIImage(named: "BackButton"), forState: .Normal)
        button.addTarget(self, action: .buttonTapped, forControlEvents: .TouchUpInside)
        addSubview(button)
        
        // CountdownView
        countDownView = CountdownView.init(timeType: timeType)
        countDownView?.delegate = self
        addSubview(countDownView!)
        
        // CollectionView
        dateView = DatesCollectionView.init(timeType: timeType)
        dateView?.delegate = self
        dateView?.dataSource = self
        addSubview(dateView!)
        
        // Constraints
        dateView!.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(snp_left).offset(0)
            make.right.equalTo(snp_right).offset(0)
            make.bottom.equalTo(snp_bottom).offset(0)
            make.height.equalTo(115)
        })
        
        countDownView!.snp_makeConstraints { (make) in
            make.top.equalTo(snp_top).offset(64)
            make.left.equalTo(snp_left).offset(0)
            make.right.equalTo(snp_right).offset(0)
            make.bottom.equalTo(dateView!.snp_top).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - UICollectionViewDelegate And DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if type == TimeType.Day {
            return 6
        }
        else{
            return 5
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == TimeType.Day {
            if section == 0 {
                return 1
            }
            else if section == 5 {
                return 1
            }
            else{
                return 2
            }
        }
        else{
            return 2
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if type == TimeType.Day {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Night", forIndexPath: indexPath) as! NightCollectionViewCell
                
                if selectedItem?.row == indexPath.row && selectedItem?.section == indexPath.section {
                    cell.nightImageView.image = UIImage(named: "Night_Selected")
                }
                else{
                    cell.nightImageView.image = UIImage(named: "Night_Unselected")
                }
                return cell
            }
            else {
                if indexPath.row == 0 {
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Day", forIndexPath: indexPath)  as! DayCollectionViewCell
                    // 默认状态第一个选择状态
                    if selectedItem?.row == 10 && selectedItem?.section == 10 {
                        if indexPath.section == 5 && indexPath.row == 0 {
                            cell.dayImageView.image = UIImage(named: "Day_Selected")
                        }
                        else{
                            cell.dayImageView.image = UIImage(named: "Day_Unselected")
                        }
                    }
                    else {
                        // SelectedItem有值
                        if selectedItem?.row == indexPath.row && selectedItem?.section == indexPath.section {
                            cell.dayImageView.image = UIImage(named: "Day_Selected")
                        }
                        else {
                            cell.dayImageView.image = UIImage(named: "Day_Unselected")
                        }
                    }
                    
                    cell.dateLabel.text = dateArray![indexPath.section - 1]["date"]
                    cell.weekLabel.text = dateArray![indexPath.section - 1]["week"]
                    return cell
                }
                else {
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Night", forIndexPath: indexPath) as! NightCollectionViewCell
                    
                    if selectedItem?.row == indexPath.row && selectedItem?.section == indexPath.section {
                        cell.nightImageView.image = UIImage(named: "Night_Selected")
                    }
                    else{
                        cell.nightImageView.image = UIImage(named: "Night_Unselected")
                    }
                    return cell
                }
            }
        }
        else {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Day", forIndexPath: indexPath) as! DayCollectionViewCell
                // SelectedItem有值
                if selectedItem?.row == indexPath.row && selectedItem?.section == indexPath.section {
                    cell.dayImageView.image = UIImage(named: "Day_Selected")
                }
                else{
                    cell.dayImageView.image = UIImage(named: "Day_Unselected")
                }
                
                cell.dateLabel.text = dateArray![indexPath.section]["date"]
                cell.weekLabel.text = dateArray![indexPath.section]["week"]
                return cell
            }
            else {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Night", forIndexPath: indexPath) as! NightCollectionViewCell
                // 默认状态第一个选择状态
                if selectedItem?.row == 10 && selectedItem?.section == 10 {
                    if indexPath.section == 4 && indexPath.row == 1 {
                        cell.nightImageView.image = UIImage(named: "Night_Selected")
                    }
                    else{
                        cell.nightImageView.image = UIImage(named: "Night_Unselected")
                    }
                }
                else {
                    // SelectedItem有值
                    if selectedItem?.row == indexPath.row && selectedItem?.section == indexPath.section {
                        cell.nightImageView.image = UIImage(named: "Night_Selected")
                    }
                    else{
                        cell.nightImageView.image = UIImage(named: "Night_Unselected")
                    }
                }
                
                return cell
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 本地存储选择的indexPath
        let data = NSKeyedArchiver.archivedDataWithRootObject(indexPath)
        UserDefault.setObject(data, forKey: "SelectedItem")
        
        if selectedItem?.section == indexPath.section && selectedItem?.row == indexPath.row {
            dismiss({ () in
                // Nothing To Do
            })
        }
        else {
            if type == TimeType.Day {
                if indexPath.section == 0 {
                    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NightCollectionViewCell
                    cell.nightImageView.image = UIImage(named: "Night_Selected")
                }
                else {
                    if indexPath.row == 0 {
                        let cell = collectionView.cellForItemAtIndexPath(indexPath)  as! DayCollectionViewCell
                        cell.dayImageView.image = UIImage(named: "Day_Selected")
                    }
                    else {
                        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NightCollectionViewCell
                        cell.nightImageView.image = UIImage(named: "Night_Selected")
                    }
                }
                // 将上一个点击的变成UnSelected
                if selectedItem?.section == 10 && selectedItem?.row == 10 {
                    // 将最后一个变成UnSelected
                    guard let cell = collectionView.cellForItemAtIndexPath(NSIndexPath.init(forItem: 0, inSection: 5))  as? DayCollectionViewCell else {
                        
                        dismiss({ () in
                            // 回调刷新新闻
                            if self.delegate != nil {
                                self.delegate?.menuViewCallBack()
                            }
                            else {
                                print("你特么没设代理啊！")
                            }
                        })
                        return
                    }
                    cell.dayImageView.image = UIImage(named: "Day_Unselected")
                }
                else {
                    guard let cell = collectionView.cellForItemAtIndexPath(selectedItem!) as? DayCollectionViewCell else {
                        // 不是DayCollectionViewCell
                        let cell = collectionView.cellForItemAtIndexPath(selectedItem!) as! NightCollectionViewCell
                        cell.nightImageView.image = UIImage(named: "Night_Unselected")
                        
                        dismiss({ () in
                            // 回调刷新新闻
                            if self.delegate != nil {
                                self.delegate?.menuViewCallBack()
                            }
                            else {
                                print("你特么没设代理啊！")
                            }
                        })
                        return
                    }
                    cell.dayImageView.image = UIImage(named: "Day_Unselected")
                }
            }
            else {
                if indexPath.row == 0 {
                    let cell = collectionView.cellForItemAtIndexPath(indexPath)  as! DayCollectionViewCell
                    cell.dayImageView.image = UIImage(named: "Day_Selected")
                }
                else {
                    let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NightCollectionViewCell
                    cell.nightImageView.image = UIImage(named: "Night_Selected")
                }
                
                // 将上一个点击的变成UnSelected
                if selectedItem?.section == 10 && selectedItem?.row == 10 {
                    // 将最后一个变成UnSelected
                    guard let cell = collectionView.cellForItemAtIndexPath(NSIndexPath.init(forItem: 1, inSection: 4))  as? NightCollectionViewCell else {
                        
                        dismiss({ () in
                            // 回调刷新新闻
                            if self.delegate != nil {
                                self.delegate?.menuViewCallBack()
                            }
                            else {
                                print("你特么没设代理啊！")
                            }
                        })
                        return
                    }
                    cell.nightImageView.image = UIImage(named: "Night_Unselected")
                }
                else {
                    guard let cell = collectionView.cellForItemAtIndexPath(selectedItem!) as? DayCollectionViewCell else {
                        // 不是DayCollectionViewCell
                        let cell = collectionView.cellForItemAtIndexPath(selectedItem!) as! NightCollectionViewCell
                        cell.nightImageView.image = UIImage(named: "Night_Unselected")
                        
                        dismiss({ () in
                            // 回调刷新新闻
                            if self.delegate != nil {
                                self.delegate?.menuViewCallBack()
                            }
                            else {
                                print("你特么没设代理啊！")
                            }
                        })
                        return
                    }
                    cell.dayImageView.image = UIImage(named: "Day_Unselected")
                }
            }
            dismiss({ () in
                // 回调刷新新闻
                if self.delegate != nil {
                    self.delegate?.menuViewCallBack()
                }
                else {
                    print("你特么没设代理啊！")
                }
            })
        }
    }
    
    //MARK: - CountdownViewDelegate
    func animationStopCallBack(callBackInterval: NSTimeInterval, callBackReverseInterval: NSTimeInterval) {
        interval = callBackInterval
        reverseInterval = callBackReverseInterval
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: .countdownAction, userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    //MARK: - UIButton Response
    func buttonTapped(sender: UIButton) {
        dismiss({ () in
            // Nothing To Do
        })
    }
    
    //MARK: - Custom Method
    func show(finishClosure: Void -> Void) {
        CurrentWindow.addSubview(self)
        
        let startTransform = CGAffineTransformScale(self.transform, 1.5, 1.5)
        self.transform = startTransform
        // 显示状态栏
        UIView.animateWithDuration(0.3, animations: {
            /*
             CGAffineTransformInvert 反向变换效果，比如原来是缩小的变换，使用这个方法之后，就变成了放大的变换
             CGAffineTransformConcat 基于上一次控件的状态进行叠加变换，在这里是叠加放大后缩小的变换
             */
            let newTransform = CGAffineTransformConcat(self.transform, CGAffineTransformInvert(self.transform))
            self.transform = newTransform
            self.alpha = 1
        }) { (true) in
            self.alpha = 1
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
            finishClosure()
        }
    }
    
    func dismiss(finishClosure: Void -> Void) {
        // 停止计时器
        if timer != nil {
            timer?.invalidate()
        }
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)
        
        self.transform = CGAffineTransformIdentity
        let endTransform = CGAffineTransformScale(self.transform, 1.5, 1.5)
        UIView.animateWithDuration(0.3, animations: {
            let newTransform = CGAffineTransformConcat(self.transform, endTransform)
            self.transform = newTransform
            self.alpha = 0
        }) { (true) in
            self.alpha = 0
            finishClosure()
            self.removeFromSuperview()
        }
    }
    
    // Loop
    func countdownLoop() {
        guard reverseInterval >= 0 else {
            timer?.invalidate()
            return
        }
        interval = interval! + 1
        reverseInterval = reverseInterval! - 1
        
        // Title
        let hour = Int(reverseInterval!/3600)
        let minute = Int(reverseInterval!%3600/60)
        let seconds = Int(reverseInterval!%60)
        let timeString = String.init(format: "%.2d%.2d%.2d", hour, minute, seconds)
        assert(timeString.characters.count == 6, "text转换位数出错:\(timeString)")
        
        let resultTextString = NSMutableString.init(string: timeString)
        resultTextString.insertString("h ", atIndex: 2)
        resultTextString.insertString("m ", atIndex: 6)
        resultTextString.insertString("s ", atIndex: 10)
        countDownView?.timeLabel?.text = resultTextString as String
        countDownView?.timeLabel?.drawAttributes(countDownView!.fontStyleArray())
        
        // StrokeEnd
        countDownView?.circleLayer.strokeEnd = CGFloat(interval!)/43200.0
    }
    
    //MARK: - Getter And Setter
    private let dayEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect.init(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView.init(effect: blur)
        effectView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        return effectView
    }()
    
    private let nightEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect.init(style: UIBlurEffectStyle.Dark)
        let effectView = UIVisualEffectView.init(effect: blur)
        effectView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        return effectView
    }()
}

//MARK: - Selector Extension
private extension Selector {
    static let countdownAction = #selector(MenuView.countdownLoop)
    static let buttonTapped = #selector(MenuView.buttonTapped(_:))
}
