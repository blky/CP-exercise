//
//  ProfileViewController.swift
//  TinderLIke
//
//  Created by Cindy Zheng on 11/18/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var image:UIImage?
    
    @IBAction func onDone(sender: UIButton) {
        dismissViewControllerAnimated(true , completion: nil)
    }
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
