//
//  LoginView.swift
//  JNews
//
//  Created by ChenKaijie on 16/8/19.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView, UITextFieldDelegate {
    private var loginView: InputView?
    private var isAccount: Bool = true
    private var distance: CGFloat = 0
    
    init() {
        super.init(frame: CurrentWindow.frame)
        self.alpha = 0
        self.backgroundColor = UIColor.clearColor()
        
        addSubview(dayEffectView)
        loginView = InputView.instantiateFromNib()
        loginView?.account.delegate = self
        loginView?.password.delegate = self
        addSubview(loginView!)
        
        configuration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        loginView?.snp_makeConstraints(closure: { (make) in
            make.center.equalTo(self.snp_center)
            make.height.equalTo(188)
            make.width.equalTo(264)
        })
        
        let gesture = UITapGestureRecognizer(target: self, action: .dismissTapped)
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dayEffectView.addGestureRecognizer(gesture)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        isAccount = textField.isEqual(loginView?.account)
        return true
    }
    
    // MARK: - KeyBoard Show Or Hide
    func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary;
        let keyboardValue: NSValue = userInfo.objectForKey("UIKeyboardFrameEndUserInfoKey") as! NSValue;
        let keyHeight: CGFloat = keyboardValue.CGRectValue().size.height;
        
        let origin_y = loginView!.frame.origin.y + loginView!.frame.size.height
        guard HEIGHT - keyHeight - origin_y < 32 else { return }
        distance = 32 - (HEIGHT - keyHeight - origin_y) <= distance ? distance : 32 - (HEIGHT - keyHeight - origin_y)
        UIView.animateWithDuration(0.3) { 
            self.loginView?.transform = CGAffineTransformMakeTranslation(0, -self.distance)
            if self.isAccount {
                self.loginView?.accountIcon.backgroundColor = UIColor.redColor()
                self.loginView?.passwordIcon.backgroundColor = UIColor.blueColor()
            }
            else {
                self.loginView?.accountIcon.backgroundColor = UIColor.blueColor()
                self.loginView?.passwordIcon.backgroundColor = UIColor.redColor()
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        distance = 0
        UIView.animateWithDuration(0.3) {
            self.loginView?.transform = CGAffineTransformIdentity
            if self.isAccount {
                self.loginView?.accountIcon.backgroundColor = UIColor.blueColor()
            }
            else {
                self.loginView?.passwordIcon.backgroundColor = UIColor.blueColor()
            }
        }
    }
    
    //MARK: - Custom Method
    func show() {
        CurrentWindow.addSubview(self)
        
        let startTransform = CGAffineTransformScale(self.transform, 1.5, 1.5)
        self.transform = startTransform
        UIView.animateWithDuration(0.3, animations: {
            let newTransform = CGAffineTransformConcat(self.transform, CGAffineTransformInvert(self.transform))
            self.transform = newTransform
            self.alpha = 1
        }) { (true) in
            self.alpha = 1
            // Monitor keyboard
            NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardShow, name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardHide, name: UIKeyboardWillHideNotification, object: nil)
        }
    }
    
    func dismiss() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        self.transform = CGAffineTransformIdentity
        let endTransform = CGAffineTransformScale(self.transform, 1.5, 1.5)
        UIView.animateWithDuration(0.3, animations: {
            let newTransform = CGAffineTransformConcat(self.transform, endTransform)
            self.transform = newTransform
            self.alpha = 0
        }) { (true) in
            self.alpha = 0
            self.removeFromSuperview()
        }
    }
    
    //MARK: - Getter
    private let dayEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect.init(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView.init(effect: blur)
        effectView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        return effectView
    }()
}

//MARK: - Selector Extension
private extension Selector {
    static let dismissTapped = #selector(LoginView.dismiss)
    static let keyboardShow = #selector(LoginView.keyboardWillShow(_:))
    static let keyboardHide = #selector(LoginView.keyboardWillHide(_:))
}
