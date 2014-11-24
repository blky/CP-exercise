//
//  InterfaceController.swift
//  watchPZ WatchKit Extension
//
//  Created by Cindy Zheng on 11/23/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var watchTable: WKInterfaceTable!
    let answers = ["A","B","C","D"]
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        loadData()
        // Configure interface objects here.
        NSLog("%@ init", self)
    }
    func loadData() {
        
        watchTable.setNumberOfRows(answers.count, withRowType: "Cell")
        
        println(answers.count)
        for (index, answer) in enumerate(answers) {
            
            let row = watchTable.rowControllerAtIndex(index) as WatchCell
            row.labelAnswer.setText(answer)
            
         }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        if segueIdentifier == "toDetail" {
            let answer = answers [rowIndex]
            return answer
        }
        return ""
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
