//
//  SearchViewController.swift
//  SwiftRakuten3
//
//  Created by Eri Tange on 2014/06/25.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var inputField:UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.inputField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if (segue.identifier == "next") {
            // pass data to next view
            
            var context = LookingResultsProducts(searchedWord: self.inputField.text)
            var destination = segue.destinationViewController as ResultViewController
            destination.context = context
            
        }
    }
}

