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
    private let largeCellId = "LargeCategoryCellId"
    private let headerId = "HeaderCategoryId"
    
    var featuredProducts: FeaturedProducts?
    var productCategories: [ProductCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Featured Products"
        
        //productCategories = ProductCategory.sampleProducts()
        
        ProductCategory.fetchFeaturedProducts { (featuredProducts) -> () in
            self.featuredProducts = featuredProducts
            self.productCategories = featuredProducts.productCategories
            self.collectionView!.reloadData()
            /* //delayed refresh
            dispatch_after(UInt64(0.25), dispatch_get_main_queue()) {
            self.collectionView!.reloadData()
            } */
        }
        
        collectionView?.backgroundColor = UIColor.whiteColor()  // - Debug
        
        collectionView?.registerClass(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.registerClass(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        
        collectionView?.registerClass(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Just 3rd Cell Will Be the Large One
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(largeCellId, forIndexPath: indexPath) as! LargeCategoryCell
            
            cell.productCategory = productCategories![indexPath.item]
            cell.categoryIndexCount = productCategories![indexPath.item].products!.count
            return cell
        }
        // Every Cell in Collection
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CategoryCell
            
        cell.productCategory = productCategories![indexPath.item]
        cell.categoryIndexCount = productCategories![indexPath.item].products!.count
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = productCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.item == 2 {
            return CGSizeMake(view.frame.width, 160)
        }
        
        return CGSizeMake(view.frame.width, 230)
    }
    
    // folowing delegate injects to header section of collectionView
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerId, forIndexPath: indexPath) as! Header
        
        header.productCategory = featuredProducts?.bannerCategory
        header.categoryIndexCount = featuredProducts?.bannerCategory?.products?.count
        
        return header
    }
    // and the resizer delegate for it
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 120)  //header container size
    }
}


class Header:CategoryCell {
    
    private let bannerCellId = "BannerCellId"
    
    override func setupViews() {
        
        productCollectionView.dataSource = self // protokols already comes from super-class
        productCollectionView.delegate = self  // protokols already comes from super-class
        
        productCollectionView.registerClass(BannerCell.self, forCellWithReuseIdentifier: bannerCellId)
        
        
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(productCollectionView)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":productCollectionView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":productCollectionView]))
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(bannerCellId, forIndexPath: indexPath) as! ProductCell
        
        cell.product = productCategory?.products?[indexPath.item]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width * 6 / 8, frame.height) //Fix: -30 for nameLabel, -2 for safe hight of dividers
    }
    
    private class BannerCell: ProductCell {
        private override func setupViews() {
            imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).CGColor // -Fix for white based picture
            imageView.layer.borderWidth = CGFloat(0.5) // -Fix for white based picture
            
            imageView.layer.cornerRadius = 0
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        }
    }
    
}




class LargeCategoryCell: CategoryCell {
    
    private let largeProductCellId = "LargeProductCellId"
    
    override func setupViews() {
        super.setupViews()
        productCollectionView.registerClass(LargeProductCell.self, forCellWithReuseIdentifier: largeProductCellId)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(largeProductCellId, forIndexPath: indexPath) as! ProductCell
        
        cell.product = productCategory?.products?[indexPath.item]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(200, frame.height - 32) //Fix: -30 for nameLabel, -2 for safe hight of dividers
    }
    
    private class LargeProductCell: ProductCell {
        private override func setupViews() {
            imageView.layer.cornerRadius = 12
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        }
    }
}







