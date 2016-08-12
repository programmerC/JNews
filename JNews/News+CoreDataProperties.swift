//
//  News+CoreDataProperties.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/26.
//  Copyright © 2016年 com.ckj. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension News {

    @NSManaged var newsType: NSNumber?
    @NSManaged var newsTitle: String?
    @NSManaged var commNum: NSNumber?
    @NSManaged var newsContent: String?
    @NSManaged var isRead: NSNumber?
    @NSManaged var newsDate: String?
    @NSManaged var dayOrNight: NSNumber?
    @NSManaged var newsID: String?
    @NSManaged var newsPicture: String?
}
