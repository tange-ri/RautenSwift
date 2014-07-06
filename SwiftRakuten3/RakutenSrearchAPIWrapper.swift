//
//  RakutenSrearchAPIWrapper.swift
//  SwiftRakuten3
//
//  Created by Eri Tange on 2014/06/25.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

import UIKit

class RakutenSrearchAPIWrapper: NSObject {

    //終わったらしてほしい処理を引数として渡す
    //その処理はvoid型
    //その処理の引数はSRProduct[]
    
    func searchRakuten(searchWord:String, currentCount:Int, completionBlock:(RakutenProducts[])->Void) {
        
        println("んん\(searchWord)")
        var urlStr = "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20130522?format=json&keyword=\(searchWord)&booksGenreId=000&page=\(currentCount)&applicationId=1005493408677495287"
        
        var encodedURL = urlStr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        var url: NSURL = NSURL.URLWithString(encodedURL)
        println(encodedURL)
        
        //NSURLSessionはダウンロードを非同期にしてくれる
        //だけどそれを含む関数全体もblockで処理しないとダウンロード結果を受け取れないよ
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task    = session.dataTaskWithURL(url, completionHandler: {
            (data, resp, err) in
            
            var jasonResults:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:nil, error: nil) as NSDictionary
            
            println(jasonResults)
            if(jasonResults["error"] != nil){return}
            
            //空の配列をつくる
            var results = RakutenProducts[]()
            var items = jasonResults["Items"]! as Dictionary<String, AnyObject>[]
            
            for itemParent:Dictionary<String, AnyObject> in items {
                //型が分からないので、型を指定して取り出す
                var item = itemParent["Item"]! as? Dictionary<String, AnyObject>
                
                //let title : AnyObject = item!["title"]! as AnyObject
                //let titleStr : String = title as String
                let titleStr = item!["title"]! as String
                let price:AnyObject = item!["itemPrice"]! as AnyObject
                let priceInt:Int = price as Int
                let imageURL:AnyObject = item!["largeImageUrl"]! as AnyObject
                let imageURLStr:String = imageURL as String
                let detailURL:AnyObject = item!["itemUrl"]! as AnyObject
                let detailURLStr:String = detailURL as String
                
                var product = RakutenProducts(title: titleStr,price: priceInt,imageURL: imageURLStr,detailURL: detailURLStr)
                
                results += product
            }
            
            //ここでUIをいじる場合はmainスレッドに戻ってくる必要がある
            //NSURLSessionはbackgroundで処理しているからもどってくる
            
            //ここでしてほしい処理を行う
            completionBlock(results)
            
            })
        
        //タスクを実行する
        task.resume()
        
    }
}
