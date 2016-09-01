//
//  ViewModel.swift
//  JNews
//
//  Created by ChenKaijie on 16/8/15.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit
import Alamofire

protocol ViewModelDelegate {
    func loadTodayNewsCallBack(dataArray: Array<NewsModel>)
    func loadSomeDayNewsCallBack(dataArray: Array<NewsModel>)
}

class ViewModel: NSObject {
    var delegate: ViewModelDelegate?
    var newsArray = Array<NewsModel>()
    
    func loadTodayNews(newsDate: String, dayOrNight: NSInteger) {
        let newsManager = NewsHelpers.shareManager
        
        Alamofire.request(.POST, "\(Base_URL)somedayNews", parameters: ["newsDate":newsDate, "dayOrNight":"\(dayOrNight)"], encoding: .JSON, headers: ["Content-Type":"application/json"])
            .responseJSON { (response) in
                guard response.result.error == nil else {
                    print("Error: ", response.result.error!)
                    return
                }
                // 清空之前的newsArray
                self.newsArray.removeAll()
                
                let dataArray = response.result.value as! NSArray
                if dataArray.count != 0 {
                    let _ = dataArray.map({ (dictionary) -> NewsModel in
                        let model = NewsModel()
                        model.newsType = dictionary.objectForKey("newsType") as? NSNumber
                        model.newsTitle = dictionary.objectForKey("newsTitle") as? String
                        model.commNum = dictionary.objectForKey("commNum") as? NSNumber
                        model.newsContent = dictionary.objectForKey("newsContent") as? String
                        model.isRead = dictionary.objectForKey("isRead") as? NSNumber
                        model.newsDate = dictionary.objectForKey("newsDate") as? String
                        model.dayOrNight = dictionary.objectForKey("dayOrNight") as? NSNumber
                        model.newsID = dictionary.objectForKey("_id") as? String
                        model.newsPicture = dictionary.objectForKey("newsPicture") as? String
                        
                        // 存储到数据库
                        newsManager.addNews(model)
                        // 添加到 newsArray
                        self.newsArray.append(model)
                        
                        return model
                    })
                }
                guard self.delegate != nil else {
                    return
                }
                self.delegate?.loadTodayNewsCallBack(self.newsArray)
        }
    }
    
    func loadSomeDayNews(newsDate: String, dayOrNight: NSInteger) {
        let newsManager = NewsHelpers.shareManager
        
        Alamofire.request(.POST, "\(Base_URL)somedayNews", parameters: ["newsDate":newsDate, "dayOrNight":"\(dayOrNight)"], encoding: .JSON, headers: ["Content-Type":"application/json"])
            .responseJSON { (response) in
                guard response.result.error == nil else {
                    print("Error: ", response.result.error!)
                    return
                }
                // 清空之前的newsArray
                self.newsArray.removeAll()
                
                let dataArray = response.result.value as! NSArray
                if dataArray.count != 0 {
                    let _ = dataArray.map({ (dictionary) -> NewsModel in
                        let model = NewsModel()
                        model.newsType = dictionary.objectForKey("newsType") as? NSNumber
                        model.newsTitle = dictionary.objectForKey("newsTitle") as? String
                        model.commNum = dictionary.objectForKey("commNum") as? NSNumber
                        model.newsContent = dictionary.objectForKey("newsContent") as? String
                        model.isRead = dictionary.objectForKey("isRead") as? NSNumber
                        model.newsDate = dictionary.objectForKey("newsDate") as? String
                        model.dayOrNight = dictionary.objectForKey("dayOrNight") as? NSNumber
                        model.newsID = dictionary.objectForKey("_id") as? String
                        model.newsPicture = dictionary.objectForKey("newsPicture") as? String
                        
                        // 存储到数据库
                        newsManager.addNews(model)
                        // 添加到 newsArray
                        self.newsArray.append(model)
                        
                        return model
                    })
                    
                }
                guard self.delegate != nil else {
                    return
                }
                self.delegate?.loadSomeDayNewsCallBack(self.newsArray)
        }
    }
}
