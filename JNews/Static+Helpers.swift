//
//  Static+Helpers.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/23.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import Foundation

// Delay Function
func Delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}