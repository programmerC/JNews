//
//  CircleLayout.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/27.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit

class CircleLayout: UICollectionViewLayout {
    var size = CGSizeZero
    var center = CGPointZero
    var radius: CGFloat = 0
    var cellCount: CGFloat = 0
    let itemSize = CGSizeMake(25, 25)
    
    override func prepareLayout() {
        super.prepareLayout()
        
        // Assign
        self.size = self.collectionView!.frame.size
        self.cellCount = CGFloat(self.collectionView!.numberOfItemsInSection(0))
        self.center = CGPointMake(self.size.width/2.0, self.size.height/2.0)
        self.radius = min(self.size.width/2.0, self.size.height)/2.0
    }
    
    // 边界改变就重新布局，默认是false
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func collectionViewContentSize() -> CGSize {
        return self.collectionView!.frame.size
    }
    
    // 对每一个Item 设置center,好让它形成圆圈
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.size = self.itemSize
        
        // 计算每一个Item的center
        let centerX = self.center.x + self.radius*CGFloat(cosf(2*Float(M_PI)*Float(indexPath.item)/Float(self.cellCount)))
        let centerY = self.center.y + self.radius*CGFloat(sinf(2*Float(M_PI)*Float(indexPath.item)/Float(self.cellCount)))
        attributes.center = CGPointMake(centerX, centerY)
        return attributes
    }
    
    // DecorationView 设置
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        attributes.size = CGSizeMake(108, 80)
        attributes.center = self.center
        return attributes
    }
    
    // 可见区域布局 先调用这个方法，再调用layoutAttributesForItemAtIndexPath这个方法
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesList = [UICollectionViewLayoutAttributes]()
        for index in 0..<Int(self.cellCount) {
            let indexPath = NSIndexPath.init(forItem: index, inSection: 0)
            attributesList.append(self.layoutAttributesForItemAtIndexPath(indexPath)!)
        }
        
        // 添加Supplementary View
        let attributes = self.layoutAttributesForSupplementaryViewOfKind("CenterSupplementary", atIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        attributesList.append(attributes!)
        return attributesList
    }
}
