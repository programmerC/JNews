//
//  InputView.swift
//  JNews
//
//  Created by ChenKaijie on 16/8/20.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class InputView: UIView {
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var accountIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    init() {
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        configuration()
    }
    
    func configuration() {
        // Background Image
        bgImageView.image = UIImage.drawImage(self.frame, cornerRadius: 8.0, color: UIColor.whiteColor())
        
        // Button Image
        let buttonImage = UIImage.drawImage(CGRectMake(0, 0, 233, 30), cornerRadius: 5.0, color: UIColor.RGBColor(0, green: 140, blue: 212, alpha: 1))
        loginButton.setBackgroundImage(buttonImage, forState: .Normal)
        
        // Input Background Border
        accountView.layer.borderWidth = 1
        passwordView.layer.borderWidth = 1
        accountView.layer.cornerRadius = 5.0
        passwordView.layer.cornerRadius = 5.0
        accountView.layer.masksToBounds = true
        passwordView.layer.masksToBounds = true
        accountView.layer.borderColor = UIColor.RGBColor(97, green: 97, blue: 97, alpha: 1.0).CGColor
        passwordView.layer.borderColor = UIColor.RGBColor(97, green: 97, blue: 97, alpha: 1.0).CGColor
    }
    
}

extension InputView {
    class func instantiateFromNib() -> InputView {
        return NSBundle.mainBundle().loadNibNamed("InputView", owner: nil, options: nil)![0] as! InputView
    }
}
