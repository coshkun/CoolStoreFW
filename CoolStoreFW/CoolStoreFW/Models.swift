//
//  Models.swift
//  CoolStoreFW
//
//  Created by coskun on 19.10.2017.
//  Copyright © 2017 coskun. All rights reserved.
//

import UIKit

class FeaturedProducts: NSObject {
    
    var bannerCategory: BannerCategory?
    var productCategories: [ProductCategory]?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "categories" {
            
            productCategories = [ProductCategory]()
            
            for dict in value as! [[String:AnyObject]] {
                let newCategory = ProductCategory()
                newCategory.setValuesForKeysWithDictionary(dict)
                
                productCategories!.append(newCategory)
            }
        } else if key == "banners" {
            if let val = value {
                bannerCategory = BannerCategory()
                bannerCategory?.setValuesForKeysWithDictionary([key : val])
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class BannerCategory: ProductCategory {
    //var banners: [Product]?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "banners" {
            
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
}

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
    
    static func fetchFeaturedProducts(completionHandler: (FeaturedProducts) -> ()){
        
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
                    
                    // ---
                    let featuredProds = FeaturedProducts()
                    featuredProds.setValuesForKeysWithDictionary(json as! [String:AnyObject])
                    // ---
                    
                    /*
                    var productCategories = [ProductCategory]()
                    
                    for dict in json["categories"] as! [[String:AnyObject]] {
                        let newCategory = ProductCategory()
                        newCategory.setValuesForKeysWithDictionary(dict)
                        
                        productCategories.append(newCategory)
                    }
                    */
                    
                    // print(productCategories) // - Debug
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionHandler(featuredProds)
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
