//
//  Models.swift
//  CoolStoreFW
//
//  Created by coskun on 19.10.2017.
//  Copyright © 2017 coskun. All rights reserved.
//

import UIKit

class ProductCategory: NSObject {

    var name: String?
    var products: [Product]?
    
    static func sampleProducts() -> [ProductCategory] {
        let bestNewBooksCategory = ProductCategory()
        bestNewBooksCategory.name = "Best New Books"
        
        var prd = [Product]()
        
        //do some logic here
        let sampleBook = Product()
        sampleBook.name = "Origin Writen By: Dan Brown"
        sampleBook.imageName = "cool-bookmarks"
        sampleBook.category = "Entertainment"
        sampleBook.price = NSNumber(float: 8.99)
        prd.append(sampleBook)
        
        bestNewBooksCategory.products = prd
        return [bestNewBooksCategory]
    }
}

class Product: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var price: NSNumber?
    var imageName: String?
}
