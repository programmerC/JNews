//
//  DatesCollectionView.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/25.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class DatesCollectionView: UICollectionView{
    var type: TimeType?
    var isFirst: Bool = true

    init(timeType: TimeType) {
        self.type = timeType
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal // 滚动方向
        flowLayout.itemSize = CGSizeMake(146/2, 115) // item Size
        
        super.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        
        self.backgroundColor = UIColor.clearColor()
        self.contentInset = UIEdgeInsetsMake(0, 5, 0, 0) // LeftInset
        
        // Register Nib
        self.registerNib(UINib.init(nibName: "DayCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Day")
        self.registerNib(UINib.init(nibName: "NightCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Night")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isFirst {
            self.isFirst = false
            if self.type == TimeType.Day {
                self.scrollToItemAtIndexPath(NSIndexPath.init(forItem: 0, inSection: 5), atScrollPosition: .CenteredHorizontally, animated: false)
            }
            else {
                self.scrollToItemAtIndexPath(NSIndexPath.init(forItem: 1, inSection: 4), atScrollPosition: .CenteredHorizontally, animated: false)
            }
        }
    }
    
}
