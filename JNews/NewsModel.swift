//
//  NewsModel.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/26.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    var newsType: NSNumber?
    var newsTitle: String?
    var commNum: NSNumber?
    var newsContent: String?
    var isRead: NSNumber?
    var newsDate: String?
    var dayOrNight: NSNumber?
    var newsID: String?
    var newsPicture: String?
    
    override init() {
        
    }
    
    convenience init(newsType: NSNumber, newsTitle: String, commNum: NSNumber, newsContent: String, isRead: NSNumber, newsDate: String, dayOrNight: NSNumber, newsID: String, newsPicture: String) {
        self.init()
        
        self.newsType = newsType
        self.newsTitle = newsTitle
        self.commNum = commNum
        self.newsContent = newsContent
        self.isRead = isRead
        self.newsDate = newsDate
        self.dayOrNight = dayOrNight
        self.newsID = newsID
        self.newsPicture = newsPicture
    }
}
