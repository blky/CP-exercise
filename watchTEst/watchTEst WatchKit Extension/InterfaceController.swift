//
//  InterfaceController.swift
//  watchTEst WatchKit Extension
//
//  Created by Cindy Zheng on 11/24/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var switchstate = true;
    
    @IBOutlet weak var firstImage: WKInterfaceImage!
    
    @IBOutlet weak var secondImage: WKInterfaceImage!
    
    @IBOutlet weak var mySwitch: WKInterfaceSwitch!
    
    
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
       
        self.secondImage.setImageNamed("card_inserting-50")
        // Configure interface objects here.
        NSLog("%@ init", self)
        
        mySwitch.setOn(self.switchstate)
         
    }

    
    
    @IBAction func changeSwitch() {
        mySwitch.setOn(!self.switchstate )
        self.switchstate = !self.switchstate
        println("\nswitch state[\(self.switchstate) ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
    }
    
    
  
    
    @IBAction func outsideButtonclick() {
         self.firstImage.setImageNamed("card_inserting-50")
        self.secondImage.setImageNamed("alarm_clock-50")
        println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
        
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
