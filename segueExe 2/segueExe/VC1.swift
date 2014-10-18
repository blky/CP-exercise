//
//  VC1.swift
//  segueExe
//
//  Created by Cindy Zheng on 10/17/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class VC1: UIViewController {
    var data:String?

    @IBOutlet weak var label: UILabel!     
    @IBOutlet weak var text: UITextField!
    
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
        println("source view contorller is \(segue.sourceViewController)")
        if segue.sourceViewController.isKindOfClass(VC2) {
            let vc = segue.sourceViewController  as VC2
             self.label.text = vc.text.text

        } else if segue.sourceViewController.isKindOfClass(VC3) {
            println("\n[ ]>>>>>> \(__FILE__.pathComponents.last!) >> \(__FUNCTION__) < \(__LINE__) >")
            let vc = segue.sourceViewController as VC3
            self.label.text = vc.text.text
        }
        

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "to2" {
          var vc = segue.destinationViewController.childViewControllers[0] as? VC2
            vc?.data = self.text.text!
            
        }
        
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "1"
        self.label.text = self.data  

        // Do any additional setup after loading the view.
    }

   

}
