//
//  UIColor+Helpers.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/11.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
// Font Color
let TopLineColor = UIColor.redColor()
let EntertainmentColor = UIColor.RGBColor(254, green: 0, blue: 126, alpha: 1)
let SportsColor = UIColor.RGBColor(255, green: 184, blue: 63, alpha: 1)
let TechnologyColor = UIColor.RGBColor(74, green: 111, blue: 230, alpha: 1)
let PoliticsColor = UIColor.RGBColor(0, green: 171, blue: 144, alpha: 1)
let HealthColor = UIColor.RGBColor(88, green: 199, blue: 69, alpha: 1)
let SocietyColor = UIColor.RGBColor(0, green: 164, blue: 245, alpha: 1)
let InternationalColor = UIColor.RGBColor(128, green: 66, blue: 145, alpha: 1)


// Selected Background Color
let TopLineSelectedColor = UIColor.RGBColor(255, green: 0, blue: 0, alpha: 0.5)
let EntertainmentSelectedColor = UIColor.RGBColor(254, green: 0, blue: 126, alpha: 0.5)
let SportsSelectedColor = UIColor.RGBColor(255, green: 184, blue: 63, alpha: 0.5)
let TechnologySelectedColor = UIColor.RGBColor(74, green: 111, blue: 230, alpha: 0.5)
let PoliticsSelectedColor = UIColor.RGBColor(0, green: 171, blue: 144, alpha: 0.5)
let HealthSelectedColor = UIColor.RGBColor(88, green: 199, blue: 69, alpha: 0.5)
let SocietySelectedColor = UIColor.RGBColor(0, green: 164, blue: 245, alpha: 0.5)
let InternationalSelectedColor = UIColor.RGBColor(128, green: 66, blue: 145, alpha: 0.5)

// Day Or Night Color
let DayColor = UIColor.RGBColor(48, green: 48, blue: 48, alpha: 1)
let NightColor = UIColor.whiteColor()
