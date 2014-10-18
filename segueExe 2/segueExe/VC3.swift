//
//  VC3.swift
//  segueExe
//
//  Created by Cindy Zheng on 10/17/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class VC3: UIViewController {
    var data:String?

    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var label: UILabel!
    
     @IBAction func onPop(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true , completion: nil )
    }
    
    
    @IBAction func onPopto1(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "3"
        self.label.text = self.data ?? ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}
