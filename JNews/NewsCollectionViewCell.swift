//
//  NewsCollectionViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/12.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

let ImageViewTag = 110
let ScrollViewTag = 10
class NewsCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var detailNewsTV: UITableView!
    var imageHeaderHeight: CGFloat = 0
    var newsModel: NewsModel!
    var index: NSInteger!
    var dataModel: NewsModel {
        get{
            return self.dataModel
        }
        set(newDataModel){
            newsModel = newDataModel
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailNewsTV.delegate = self
        detailNewsTV.dataSource = self
        // Register Nib
        detailNewsTV.registerNib(UINib.init(nibName: "DetailTopTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "DetailTopCell")
        detailNewsTV.registerNib(UINib.init(nibName: "DetailTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "DetailCell")
        // Image Header Height
        imageHeaderHeight = HEIGHT*0.68
    }
    
    //MARK: - UITableViewDataSource And Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.imageHeaderHeight
        }
        else{
            let title = self.newsModel.newsTitle!
            let content = self.newsModel.newsContent!
            let titleHeight = title.getHeight(title, margin: 26, fontSize: 20)
            let contentHeight = content.getHeight(content, margin: 26, fontSize: 15)
            
            return ((titleHeight < 24) ? 24 : titleHeight) + (contentHeight < 18 ? 18 : contentHeight) + 48 + 18;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailTopCell", forIndexPath: indexPath) as! DetailTopTableViewCell
            // ScrollView Setting
            cell.imageScrollView.delegate = self
            cell.imageScrollView.tag = ScrollViewTag
            cell.contentImageView.tag = ImageViewTag
            // Assign
            cell.index = self.index
            cell.dataModel = self.newsModel
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! DetailTableViewCell
            cell.dataModel = self.newsModel
            return cell
        }
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 如果是Cell里面的scrollView直接跳过
        guard scrollView.tag != ScrollViewTag else {
            return
        }
        // 防止第一个Cell不在visiableCells数组引发的crash
        guard let cell = self.detailNewsTV.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0)) as? DetailTopTableViewCell else {
            return
        }
        let imageScrollView = cell.viewWithTag(ScrollViewTag) as! UIScrollView
        var frame = imageScrollView.frame
        frame.size.height = max(self.imageHeaderHeight - scrollView.contentOffset.y, 0)
        frame.origin.y = scrollView.contentOffset.y
        imageScrollView.frame = frame
        imageScrollView.zoomScale = abs(min(scrollView.contentOffset.y, 0)/WIDTH) + 1
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollView.viewWithTag(ImageViewTag)
    }

}
