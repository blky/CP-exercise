//
//  VC2.swift
//  segueExe
//
//  Created by Cindy Zheng on 10/17/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class VC2: UIViewController {

    @IBAction func unwindtoVC2(segue: UIStoryboardSegue) {
        
        if segue.sourceViewController.isKindOfClass(VC3) {
             let vc = segue.sourceViewController as VC3
             self.label.text = vc.text.text
        } else {
            
        }
        
    }
    var data:String?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var text: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "to3" {
            
            let vc = segue.destinationViewController as VC3
            vc.data = self.text.text
            
        } else   {
            
        }
    }
    @IBAction func onDismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true , completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = "2"
        self.label.text = self.data

        // Do any additional setup after loading the view.
    }

    

}
