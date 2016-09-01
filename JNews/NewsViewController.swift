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
    @IBOutlet weak var homeButton: UIButton!

    var newsArray: Array = Array<NewsModel>()
    var modelArray: Array<NewsModel> {
        get{
            return self.modelArray
        }
        set(newModelArray){
            self.newsArray = newModelArray
        }
    }
    var isFirst = true
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
        self.scanArray.append(currentRow!.row)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 8.0, options: .AllowUserInteraction, animations: {
            self.backButton.hidden = false
            self.homeButton.hidden = false
            self.backButton.transform = CGAffineTransformMakeTranslation(15, 0)
            self.homeButton.transform = CGAffineTransformMakeTranslation(0, 11)
            }) { (true) in
                self.backButton.hidden = false
                self.homeButton.hidden = false
                self.backButton.frame.origin.x = 15
                self.homeButton.frame.origin.y = 11
        }
        // Show NewsNumberTipsView
        let tipsView = NewsNumberTipsView.init(currentNumber: currentRow!.row + 1, totalNumber: newsArray.count, frame: CGRectMake(self.view.center.x - 25, HEIGHT - 37, 50, 25))
        self.view.addSubview(tipsView)
        UIView.animateWithDuration(1.2, animations: {
            tipsView.alpha = 0
            }) { (true) in
                tipsView.alpha = 0
                tipsView.removeFromSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.view.layoutIfNeeded()
        // Only Execute Only Once
        guard isFirst else {
            return
        }
        isFirst = false
        backButton.frame.origin.x = -40
        homeButton.frame.origin.y = -40
        self.newsCV.scrollToItemAtIndexPath(currentRow!, atScrollPosition: .CenteredHorizontally, animated: false)
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
        
        // Show NewsNumberTipsView
        let tipsView = NewsNumberTipsView.init(currentNumber: indexPath!.row + 1, totalNumber: newsArray.count, frame: CGRectMake(self.view.center.x - 25, HEIGHT - 37, 50, 25))
        self.view.addSubview(tipsView)
        UIView.animateWithDuration(1.2, animations: {
            tipsView.alpha = 0
        }) { (true) in
            tipsView.alpha = 0
            tipsView.removeFromSuperview()
        }
    }

    //MARK: - UIButton Response
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        self.selectedClosure(selectedArray: scanArray) //回调执行动画
    }
    
    @IBAction func homeAction(sender: UIButton) {
        let loginView = LoginView.init()
        loginView.show()
    }
}
