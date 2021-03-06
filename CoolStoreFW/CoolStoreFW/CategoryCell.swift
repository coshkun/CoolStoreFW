//
//  CategoryCell.swift
//  CoolStoreFW
//
//  Created by coskun on 19.10.2017.
//  Copyright © 2017 coskun. All rights reserved.
//

import UIKit


class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "ProductCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Books"
        label.font = UIFont.systemFontOfSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let dividerLine: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }()
    
    func setupViews() {
        backgroundColor = UIColor.clearColor()  // - Debug
        
        addSubview(productCollectionView)
        addSubview(dividerLine)
        addSubview(nameLabel)
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        productCollectionView.registerClass(ProductCell.self, forCellWithReuseIdentifier: cellId)
        
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dividerLine]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":productCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":productCollectionView, "v1":dividerLine, "nameLabel":nameLabel]))
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, frame.height - 32) //Fix: -30 for nameLabel, -2 for safe hight of dividers
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
}

class ProductCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cool-bookmarks")!
        
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Origin Writen By: Dan Brown"
        label.font = UIFont.systemFontOfSize(12)
        label.numberOfLines = 2
        
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = UIColor.darkGrayColor()
        
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$8.99"
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = UIColor.darkGrayColor()
        
        return label
    }()
    
    func setupViews() {
        //backgroundColor = UIColor.blackColor() // - Debug
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        imageView.frame = CGRectMake(0, 0, frame.width, frame.width)
        nameLabel.frame = CGRectMake(0, frame.width + 2, frame.width, 40)
        categoryLabel.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
        priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
    }
}







