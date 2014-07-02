//
//  LookingResultsProducts.swift
//  SwiftRakuten3
//
//  Created by Eri Tange on 2014/06/25.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

import UIKit

class LookingResultsProducts: NSObject {
    
    var results:RakutenProducts[]
    var searchedWord:String
    var apiWrapper:RakutenSrearchAPIWrapper
    var isLastPage = false
    
    init (searchedWord:String){
        let array = RakutenProducts[]()
        self.results = array
        self.searchedWord = searchedWord
        let wrapper = RakutenSrearchAPIWrapper()
        self.apiWrapper = wrapper
        super.init()
    }
    
    func loadNextPage(completionBlock:()->Void){
        
        var wrapper = RakutenSrearchAPIWrapper()
        
        //メソッド呼び出しのみ(void型)
        //実行してほしい処理を引数としてvoid型のメソッドを渡す
        //{ してほしい処理　}
        
        wrapper.searchRakuten(self.searchedWord, currentCount: self.results.count/30 + 1) {
            
            //引数としてわたされたblockの引数resultsをnewResultsに入れている
            newResults in
            
            if newResults.count == 0{
                
                self.isLastPage = true
                
            }else{
                
                println(self.results.count)
                self.results.extend(newResults)
                println(self.results.count)
                
            }
            
            //dispatch
            dispatch_async(dispatch_get_main_queue()){
                
                completionBlock()
                
            }
            
        }
        
    }
    
    func productAtIndex(index:Int)-> RakutenProducts{
        
        //println(self.results[1])
        
        return self.results[index]
    }
    
//    func makeLookingResults(completionBlock:(LookingResultsProducts)->Void){
//        
//        self.loadNextPage(){
//            
//        completionBlock(self)
//        
//        }
//    }
    
    func count() -> Int {
        
        return self.results.count
    }


}
