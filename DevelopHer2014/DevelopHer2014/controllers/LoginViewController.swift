//
//  LoginViewController.swift
//  DevelopHer2014
//
//  Created by Maricel Quesada on 11/14/14.
//  Copyright (c) 2014 Maricel-Betsy-Cindy-Alexa-Diana. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var linkedInClient: LinkedInClient!
    var userObjId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.linkedInClient = LinkedInClient.sharedInstance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onShowCategories(sender: AnyObject) {
        
        var cat = ParseCategory.query() as PFQuery
        cat.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!,error: NSError!) -> Void in
            
            for obj in objects {
                var category = obj as ParseCategory
                println("categories are \(category.name!)")
            }
        }
        
    }
    @IBAction func onLogout(sender: UIButton) {
       
        User.currentUser?.logout()
     }

    @IBAction func onAddInterest(sender: AnyObject) {
        
        var intQuery = ParseInterest.query() as PFQuery
        intQuery.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!,error: NSError!) -> Void in
            
            for obj in objects {
                var interest = obj as ParseInterest
                println("interests are \(interest.name!)")
            }
        }
        
    }
    
    @IBAction func connectToLinkedIn(sender: AnyObject) {
        User.loginWithCompletion { () -> Void in
            println("User logged in")
        }
    }
    @IBAction func onShowUserwithsameInterest(sender: AnyObject) {
    
        listAllUserInterestList()
    
    
    }
    
    func listCurrentUserInterests(){
        var interestList = NSMutableArray();
        
        var query = PFUser.query() as PFQuery
        query.whereKey("username", equalTo: User.currentUser?.email)
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            if objects.count == 1 {
                var parseUser = objects[0] as ParseUser
                var relation = parseUser.relationForKey("InterestType")
                relation.query().findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, errpr: NSError!) -> Void in
                    if error != nil {
                        println("error getting interests")
                    } else {
                        for obj in objects {
                            let interest = obj as ParseInterest
                            interestList.addObject(obj.name!)
                            
                        }
                        
                        println("current user interests: \(interestList)")
                        
                    }
                })
                
                
            } else {
                
            }
        }
    }
    func listAllUserMatchInterestList (interestList:NSArray) {
        
    }
    
    func listAllUserInterestList ( ) {
         var allUserandtheirInterests = NSMutableArray()
        var interestList = NSMutableArray()
//        var interestList = String?;
        var interestsStringList = ""
        
        
        var query = ParseUser.query()
        query.findObjectsInBackgroundWithBlock { (objects :[AnyObject]!, error : NSError!) -> Void in
            
            if error == nil {
                for obj in objects {
                    let parseUser =  obj as ParseUser
                    var relation = parseUser.relationForKey("InterestType")
                    relation.query().findObjectsInBackgroundWithBlock({ (interestObjects:[AnyObject]!, InterestError: NSError!) -> Void in
                      
                        for obj in interestObjects {
                            let interest = obj as ParseInterest
//                            interestList.addObject(interest.name!)
                          
                          interestsStringList = interestsStringList   + "," +  interest.name!
                        }
                        
                          var temp = NSString(string: "\(interestList)")
                          var singleUserInfo = ["userName" : User.currentUser!.firstName!, "allInterests": interestsStringList]
                        println("user : \(singleUserInfo)")
                        
                    })
                }
                
                
            } else {
                println("list user error")
            }
            
        }
        
        
        
        
//        var user = PFUser.currentUser()
//        var relation = user.relationForKey("rsvped")
//        relation.query().findObjectsInBackgroundWithBlock {
//            (objects: [AnyObject]!, error: NSError!) -> Void in
//            if error != nil {
//                // There was an error
//            } else {
//                for each in objects {
//                    var rsvpe = each as parseEvent
//                    println("\(PFUser.currentUser().username) rsvped event(s) : \(rsvpe.EventName!)")
//                }
//            }
//        }
        
    }
    
    @IBAction func onAddInterestedToUser(sender: UIButton) {
        
         let InterestedObjectId = "ekkbd2rE8T"
        let CategoryObjectId = "DT7ql1hboY"
    
        var query = PFUser.query() as PFQuery
        query.whereKey("username", equalTo: User.currentUser?.email)
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            
            if objects.count == 1 {
                var parseUser = objects[0] as ParseUser
                 //add interest
                var relation = parseUser.relationForKey("InterestType")
                var interest = ParseInterest.query() as PFQuery
                interest.getObjectInBackgroundWithId(InterestedObjectId, block: { (object:PFObject!, error: NSError!) -> Void in
                    if object != nil {
                        
                        relation.addObject(object )
                        println("getting interest by id \(InterestedObjectId)")

                        parseUser.saveEventually()
                        println("save interest")
                    } else {
                        println("adding interest fail")
                    }
                    
                })
                
                var interestQuery = relation.query()
                interestQuery.whereKey("objectId", equalTo: InterestedObjectId)
                
             } else {
                println("error getting user iwth object id")
            }
            
        }
        
    }


}
