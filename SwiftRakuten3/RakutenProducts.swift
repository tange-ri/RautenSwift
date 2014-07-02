//
//  RakutenProducts.swift
//  SwiftRakuten3
//
//  Created by Eri Tange on 2014/06/25.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

import UIKit

class RakutenProducts: NSObject {
    
    var title:String
    var price:Int
    var imageURL:String
    var detailURL:String
    
    init (title:String, price:Int, imageURL:String, detailURL:String) {
        self.title = title
        self.price = price
        self.imageURL = imageURL
        self.detailURL = detailURL
        super.init()
    }

}
