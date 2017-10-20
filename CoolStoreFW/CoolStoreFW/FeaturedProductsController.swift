//
//  ViewController.swift
//  CoolStoreFW
//
//  Created by coskun on 19.10.2017.
//  Copyright © 2017 coskun. All rights reserved.
//

import UIKit

class FeaturedProductsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "CategoryCellId"
    
    var productCategories: [ProductCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productCategories = ProductCategory.sampleProducts()
        
        collectionView?.backgroundColor = UIColor.whiteColor()  // - Debug
        
        collectionView?.registerClass(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CategoryCell
        
        cell.productCategory = productCategories![indexPath.row]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = productCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 230)
    }
}









