//
//  NewsHelpers.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/26.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import CoreData

class NewsHelpers: CoreDataHelpers {
    
    static let shareManager = NewsHelpers()
    private override init() {
        // 保证init方法的私有性，确保单例真正的唯一
    }
    
    //MARK: - Find News
    func findNews(newsDate: String, dayOrNight: NSInteger) -> Array<NewsModel> {
        // Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest.init(entityName: self.storeName);
        
        // Predicate
        fetchRequest.predicate = NSPredicate.init(format: "newsDate = %@ AND dayOrNight = %@", newsDate, dayOrNight as NSNumber);
        
        // Sort OrderAscend
        let sortDescriptor: NSSortDescriptor = NSSortDescriptor.init(key: "newsType", ascending: true);
        fetchRequest.sortDescriptors = [sortDescriptor];
        
        // Execute Request
        let dataArray: NSArray = try! self.managedObjectContext.executeFetchRequest(fetchRequest);
        
        // Return Array
        let resultArray = dataArray.map { (resultItem) -> NewsModel in
            let newsEntity: News = resultItem as! News
            let newsModel: NewsModel = NewsModel()
            
            newsModel.newsType = newsEntity.newsType
            newsModel.newsTitle = newsEntity.newsTitle
            newsModel.commNum = newsEntity.commNum
            newsModel.newsContent = newsEntity.newsContent
            newsModel.isRead = newsEntity.isRead
            newsModel.newsDate = newsEntity.newsDate
            newsModel.dayOrNight = newsEntity.dayOrNight
            newsModel.newsID = newsEntity.newsID
            newsModel.newsPicture = newsEntity.newsPicture
            return newsModel
        }
        return resultArray;
    }
    
    func findLastestNews() -> Array<NewsModel> {
        // Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest.init(entityName: self.storeName);
        
        // Sort OrderDescend
        let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor.init(key: "newsDate", ascending: false);
        let dayOrNightSortDescriptor: NSSortDescriptor = NSSortDescriptor.init(key: "dayOrNight", ascending: false)
        fetchRequest.sortDescriptors = [dateSortDescriptor, dayOrNightSortDescriptor];
        
        // Execute Request
        let dataArray: NSArray = try! self.managedObjectContext.executeFetchRequest(fetchRequest);
    
        // Return Array (截取八个)
        if dataArray.count >= 8 {
            let resultArray = dataArray.subarrayWithRange(NSMakeRange(0, 8)).map { (resultItem) -> NewsModel in
                let newsEntity: News = resultItem as! News
                let newsModel: NewsModel = NewsModel()
                
                newsModel.newsType = newsEntity.newsType
                newsModel.newsTitle = newsEntity.newsTitle
                newsModel.commNum = newsEntity.commNum
                newsModel.newsContent = newsEntity.newsContent
                newsModel.isRead = newsEntity.isRead
                newsModel.newsDate = newsEntity.newsDate
                newsModel.dayOrNight = newsEntity.dayOrNight
                newsModel.newsID = newsEntity.newsID
                newsModel.newsPicture = newsEntity.newsPicture
                return newsModel
            }
            return resultArray;
        }
        else{
            let resultArray = dataArray.map { (resultItem) -> NewsModel in
                let newsEntity: News = resultItem as! News
                let newsModel: NewsModel = NewsModel()
                
                newsModel.newsType = newsEntity.newsType
                newsModel.newsTitle = newsEntity.newsTitle
                newsModel.commNum = newsEntity.commNum
                newsModel.newsContent = newsEntity.newsContent
                newsModel.isRead = newsEntity.isRead
                newsModel.newsDate = newsEntity.newsDate
                newsModel.dayOrNight = newsEntity.dayOrNight
                newsModel.newsID = newsEntity.newsID
                newsModel.newsPicture = newsEntity.newsPicture
                return newsModel
            }
            return resultArray;
        }
    }
    
    //MARK: - Add Data
    func addNews(newsModel: NewsModel) {
        let newAddItem: News = NSEntityDescription.insertNewObjectForEntityForName(self.storeName, inManagedObjectContext: self.managedObjectContext) as! News;
        newAddItem.newsType = newsModel.newsType
        newAddItem.newsTitle = newsModel.newsTitle
        newAddItem.commNum = newsModel.commNum
        newAddItem.newsContent = newsModel.newsContent
        newAddItem.isRead = newsModel.isRead
        newAddItem.newsDate = newsModel.newsDate
        newAddItem.dayOrNight = newsModel.dayOrNight
        newAddItem.newsID = newsModel.newsID
        newAddItem.newsPicture = newsModel.newsPicture
        self.saveContext();
    }
    
    //MARK: - Update Data
    func updateNews(newsID: String) {
        // Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest.init(entityName: self.storeName);
        
        // Predicate
        fetchRequest.predicate = NSPredicate.init(format: "newsID = %@", newsID);
        
        // Execute Request
        let dataArray: NSArray = try! self.managedObjectContext.executeFetchRequest(fetchRequest);
        for resultItem in dataArray {
            let entity: News = resultItem as! News
            entity.isRead = NSNumber.init(short: 1)
        }
        self.saveContext()
    }
    
    //MARK: - Delete Data
    func deleteNews(newsDate: String) {
        // Fetch Request
        let fetchRequest: NSFetchRequest = NSFetchRequest.init(entityName: self.storeName);
        
        // Predicate
        fetchRequest.predicate = NSPredicate.init(format: "newsDate <= %@", newsDate);
        
        // Execute Request
        let dataArray: NSArray = try! self.managedObjectContext.executeFetchRequest(fetchRequest);
        for resultItem in dataArray {
            let entity: News = resultItem as! News
            self.managedObjectContext.deleteObject(entity)
        }
        self.saveContext()
    }
}
