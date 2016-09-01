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
class NewsCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource, DetailShareTableViewCellDelegate, ShareViewDelegate {
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
        detailNewsTV.registerNib(UINib.init(nibName: "DetailShareTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "DetailShareCell")
        // Image Header Height
        imageHeaderHeight = HEIGHT*0.68
    }
    
    //MARK: - UITableViewDataSource And Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.imageHeaderHeight
        }
        else if indexPath.row == 1 {
            let title = self.newsModel.newsTitle!
            let content = self.newsModel.newsContent!
            let titleHeight = title.getHeight(title, margin: 26, fontSize: 20)
            let contentHeight = content.getHeight(content, margin: 26, fontSize: 15)
            
            return ((titleHeight < 24) ? 24 : titleHeight) + (contentHeight < 18 ? 18 : contentHeight) + 26 + 26;
        }
        else {
            return 54
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
            cell.index = index
            cell.dataModel = newsModel
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! DetailTableViewCell
            cell.dataModel = newsModel
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailShareCell", forIndexPath: indexPath) as! DetailShareTableViewCell
            cell.delegate = self
            cell.newsType = newsModel.newsType!.integerValue
            return cell
        }
    }
    
    //MARK: - DetailShareTableViewCellDelegate
    func shareCellButtonCallBack() {
        let shareView = ShareView.init()
        shareView.delegate = self
        shareView.show()
    }
    
    //MARK: - ShareViewDelegate
    func shareViewButtonCallBack(type: ShareType) {
        switch type {
        case .Sina:
            print("Sina")
        case .WeChatTimeLine:
            print("WeChatTimeLine")
        case .WeChatAppMessage:
            print("WeChatAppMessage")
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
