//
//  NewsViewController.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/12.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    @IBOutlet weak var newsCV: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    var newsArray: Array = Array<NewsModel>()
    var modelArray: Array<NewsModel> {
        get{
            return self.modelArray
        }
        set(newModelArray){
            self.newsArray = newModelArray
        }
    }
    // 当前的视图
    var currentRow: NSIndexPath?
    // 记录浏览过的新闻序号
    var scanArray = Array<Int>()
    // Closure
    typealias backClosure = (selectedArray: Array<Int>) -> Void
    var selectedClosure: backClosure!
    
    //MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register Nib
        self.newsCV.registerNib(UINib.init(nibName: "NewsCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "DetailNews")
        
        // Add Current Row
        self.scanArray.append(self.currentRow!.row)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        self.view.layoutIfNeeded()
        self.newsCV.scrollToItemAtIndexPath(self.currentRow!, atScrollPosition: .CenteredHorizontally, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIColletionViewDataSource And Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsArray.count
    }
   
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.bounds.width - 5, collectionView.bounds.height)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailNews", forIndexPath: indexPath) as! NewsCollectionViewCell
        cell.index = indexPath.row
        cell.dataModel = self.newsArray[indexPath.row]
        cell.detailNewsTV.reloadData()

        return cell
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let cell: NewsCollectionViewCell = self.newsCV.visibleCells().first as! NewsCollectionViewCell
        let indexPath = self.newsCV.indexPathForCell(cell)
        if !self.scanArray.contains(indexPath!.row) {
            self.scanArray.append(indexPath!.row)
        }
    }

    //MARK: - UIButton Response
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        self.selectedClosure(selectedArray: scanArray) //回调执行动画
    }
}
