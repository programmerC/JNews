//
//  UIImage+Helpers.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/11.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func drawImage(rect: CGRect, cornerRadius: CGFloat, color: UIColor) -> UIImage {
        // 开始绘图
        UIGraphicsBeginImageContext(rect.size)
        
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        bezierPath.addClip()
        // 填充颜色
        color.setFill()
        bezierPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
