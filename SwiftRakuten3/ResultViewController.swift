//
//  ResultViewController.swift
//  SwiftRakuten3
//
//  Created by Eri Tange on 2014/06/25.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

import UIKit

class ResultViewController:UITableViewController,UITableViewDataSource, UITableViewDelegate{
    
    var context:LookingResultsProducts!
    var searchedWord:String!
    var time:Int = 0
    
    override func scrollViewDidScroll(scrollView: UIScrollView!){
    
    var indexPaths = self.tableView.indexPathsForVisibleRows()
    var index = indexPaths as NSIndexPath[]
    var row = index.bridgeToObjectiveC().lastObject.row
    
    println(row)
    
    if row >= self.context.count()-1 && !self.context.isLastPage {
    
        self.context.loadNextPage(){
            
            dispatch_async(dispatch_get_main_queue()){
                
            self.tableView.reloadData()
                
            }
        }
    }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    println("ここあ\(self.context.results.count)")
        
    return self.context.results.count
    
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
    
    //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell!
    
    //それぞれのindexのproductをつくる
    var index:Int = indexPath.row
    var product:RakutenProducts = self.context.productAtIndex(index)
    
    var titleLabel = cell.viewWithTag(1) as UILabel!
    var priceLabel = cell.viewWithTag(2) as UILabel!
    var imageView = cell.viewWithTag(3) as UIImageView!
    
    titleLabel.text = product.title
    priceLabel.text = "\(product.price)"
    
        var q_global: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        var q_main: dispatch_queue_t  = dispatch_get_main_queue();
        
        dispatch_async(q_global, {
            var imageURL: NSURL = NSURL.URLWithString(product.imageURL)
            var imageData: NSData = NSData(contentsOfURL: imageURL)
            var image: UIImage = UIImage(data: imageData)
            
            // 更新はmain threadで
            dispatch_async(q_main, {
                imageView.image = image
                })
            })
    
    return cell
    }
    
    override func viewDidAppear(animated: Bool) {
    
        super.viewDidAppear(animated)
        
        println("ああああい")
        //最初に呼ばれちゃってる
        self.context.loadNextPage(){
            
        println("テスト\(self.context.count())")
            self.tableView.reloadData()
   
        }
    }
}

