//
//  ProductDetailsController.swift
//  CoolStoreFW
//
//  Created by coskun on 22.10.2017.
//  Copyright © 2017 coskun. All rights reserved.
//

import UIKit

class ProductDetailsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var headerId = "headerId"
    
    var product: Product? {
        didSet {
            navigationItem.title = product?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(ProductDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerId, forIndexPath: indexPath) as! ProductDetailHeader
        header.product = product
        return header
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 170)
    }
    
}


class ProductDetailHeader: BaseCell {
    
    var product: Product? {
        didSet {
            if let iname = product?.imageName {
                imageView.image = UIImage(named: iname)
            }
            if let name = product?.name {
                nameLabel.text = name
            }
            if let price = product?.price {
                buyButton.setTitle("BUY $\(price.floatValue)", forState: .Normal)
            }
            if let category = product?.category {
                categoryLabel.text = "Category: \(category)"
            }
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Comments", "Related"])
        sc.tintColor = UIColor.darkGrayColor()
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    var nameLabel: UILabel = {
        let nl = UILabel()
        nl.text = ""
        nl.font = UIFont.systemFontOfSize(14)
        return nl
    }()
    
    var categoryLabel: UILabel = {
        let nl = UILabel()
        nl.text = "Category"
        nl.font = UIFont.systemFontOfSize(11)
        nl.textColor = UIColor.darkGrayColor()
        return nl
    }()
    
    var buyButton: UIButton = {
        let button = UIButton(type: UIButtonType.System)
        button.setTitle("BUY", forState: .Normal)
        button.tintColor = UIColor.blueColor()
        button.layer.borderColor = UIColor(red: 0, green: 128/255, blue: 250/255, alpha: 1).CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(11)
        return button
    }()
    
    var dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(buyButton)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("V:|-14-[v0(100)]|", views: imageView)
        
        addConstraintsWithFormat("H:|-122-[v0]|", views: categoryLabel)
        addConstraintsWithFormat("V:|-14-[v0(20)]-2-[v1(20)]", views: nameLabel, categoryLabel)
        
        addConstraintsWithFormat("H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithFormat("V:[v0(34)]-8-|", views: segmentedControl)
        
        addConstraintsWithFormat("H:[v0(80)]-14-|", views: buyButton)
        addConstraintsWithFormat("V:[v0(32)]-56-|", views: buyButton)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(0.5)]|", views: dividerLineView)
        
        /*
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0(100)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-14-[v0(100)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":imageView]))
        */
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}










