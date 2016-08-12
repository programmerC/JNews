//
//  MainBottomTableViewCell.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/27.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

protocol MainBottomTableViewCellDelegate {
    func listButtonCallBack()
}

class MainBottomTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var bottomCV: UICollectionView!
    var number = 0
    var delegate: MainBottomTableViewCellDelegate?
    var newsArray: Array = Array<NewsModel>()
    var modelArray: Array<NewsModel> {
        get{
            return self.modelArray
        }
        set(newModelArray){
            self.newsArray = newModelArray
            self.bottomCV.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomCV.dataSource = self
        // Resigter Nib
        bottomCV.registerNib(UINib.init(nibName: "BottomCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Circle")
        bottomCV.registerNib(UINib.init(nibName: "DecorationCollectionReusableView", bundle: NSBundle.mainBundle()), forSupplementaryViewOfKind: "CenterSupplementary", withReuseIdentifier: "Supplementary")
    }
    
    //MARK: - UICollectionViewDataSource And Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        self
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(25, 25)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Circle", forIndexPath: indexPath) as! BottomCollectionViewCell
        cell.title.text = "\(indexPath.row + 1)"
        // 判断是否已读
        let model = self.newsArray[indexPath.row]
        guard model.isRead!.intValue == 0 else {
            cell.title.layer.borderWidth = 0
            cell.title.textColor = UIColor.whiteColor()
            switch model.newsType!.intValue {
            case 0:
                cell.title.backgroundColor = TopLineColor
            case 1:
                cell.title.backgroundColor = EntertainmentColor
            case 2:
                cell.title.backgroundColor = SportsColor
            case 3:
                cell.title.backgroundColor = TechnologyColor
            case 4:
                cell.title.backgroundColor = PoliticsColor
            case 5:
                cell.title.backgroundColor = SocietyColor
            case 6:
                cell.title.backgroundColor = HealthColor
            case 7:
                cell.title.backgroundColor = InternationalColor
            default:
                return cell
            }
            return cell
        }
        cell.title.layer.borderWidth = 1
        cell.title.textColor = UIColor.blackColor()
        cell.title.backgroundColor = UIColor.clearColor()
//        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Supplementary", forIndexPath: indexPath) as! DecorationCollectionReusableView
        
        self.number = 0
        for model in self.newsArray {
            if model.isRead?.intValue == 1 {
                self.number += 1
            }
        }
        view.readLabel.text = "\(self.number)/\(self.newsArray.count)"
        return view
    }
    
    //MARK: - UIButton Response
    @IBAction func listButtonAction(sender: UIButton) {
        // Show Read List View
        if self.delegate != nil {
            self.delegate?.listButtonCallBack()
        }
    }
    
    //MARK: - Animation Start
    func animationStart(row: NSInteger) {
        let model = self.newsArray[row]
        guard model.isRead?.intValue == 1 else {
            return
        }
        let cell = self.bottomCV.cellForItemAtIndexPath(NSIndexPath(forItem: row, inSection: 0)) as! BottomCollectionViewCell
        var color = UIColor.clearColor()

        switch model.newsType!.intValue {
        case 0:
            color = TopLineColor
        case 1:
            color = EntertainmentColor
        case 2:
            color = SportsColor
        case 3:
            color = TechnologyColor
        case 4:
            color = PoliticsColor
        case 5:
            color = SocietyColor
        case 6:
            color = HealthColor
        case 7:
            color = InternationalColor
        default:
            return
        }
        // Animation
        UIView.animateWithDuration(0.8, animations: {
            cell.title.layer.borderWidth = 0
            cell.title.textColor = UIColor.whiteColor()
            cell.title.backgroundColor = color
        }) { (true) in
            // Do Nothing
        }
        // Have read
        self.number += 1
        if #available(iOS 9.0, *) {
            let supplementaryView = self.bottomCV.visibleSupplementaryViewsOfKind("CenterSupplementary").first as! DecorationCollectionReusableView
            supplementaryView.readLabel.text = "\(self.number)/\(self.newsArray.count)"
        } else {
            // Fallback on earlier versions
            let supplementaryView = self.bottomCV.dequeueReusableSupplementaryViewOfKind("CenterSupplementary", withReuseIdentifier: "Supplementary", forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! DecorationCollectionReusableView
            supplementaryView.readLabel.text = "\(self.number)/\(self.newsArray.count)"
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
