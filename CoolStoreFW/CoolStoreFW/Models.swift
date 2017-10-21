//
//  Models.swift
//  CoolStoreFW
//
//  Created by coskun on 19.10.2017.
//  Copyright © 2017 coskun. All rights reserved.
//

import UIKit

class ProductCategory: NSObject {
    
    var id: NSNumber?
    //var isActive: Bool?
    var name: String?
    var products: [Product]?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "products" {
            
            products = [Product]()
            for dict in value as! [[String:AnyObject]] {
                let newProduct = Product()
                newProduct.setValuesForKeysWithDictionary(dict)
                products!.append(newProduct)
            }
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedProducts(completionHandler: ([ProductCategory]) -> ()){
        
        let urlString = "http://www.json-generator.com/api/json/get/bTOZldebhe?indent=2"
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do {
                    let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                    
                    var productCategories = [ProductCategory]()
                    
                    for dict in json["categories"] as! [[String:AnyObject]] {
                        let newCategory = ProductCategory()
                        newCategory.setValuesForKeysWithDictionary(dict)
                        
                        productCategories.append(newCategory)
                    }
                    // print(productCategories) // - Debug
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionHandler(productCategories)
                    })
                    
                } catch let err {
                    print(" *** JSON Parsing Err: \(err)")
                }
                
            }
        }.resume()
        
    }
    
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
        
        let bestNewGamesCategory = ProductCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        var gms = [Product]()
        
        let telePaint = Product()
        telePaint.name = "Telepaint"
        telePaint.category = "Games"
        telePaint.imageName = "telepaint"
        telePaint.price = NSNumber(float: 2.99)
        gms.append(telePaint)
        
        bestNewGamesCategory.products = gms
        bestNewBooksCategory.products = prd
        return [bestNewBooksCategory, bestNewGamesCategory]
    }
}

class Product: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var price: NSNumber?
    var imageName: String?
    //var isActive: Bool?
    
}
