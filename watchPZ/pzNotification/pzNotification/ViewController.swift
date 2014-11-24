//
//  ViewController.swift
//  pzNotification
//
//  Created by Cindy Zheng on 11/23/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let locaitonNotification = UILocalNotification()
        locaitonNotification.alertAction = "test by pz"
        locaitonNotification.alertBody = "test alert body"
        locaitonNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(locaitonNotification)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

