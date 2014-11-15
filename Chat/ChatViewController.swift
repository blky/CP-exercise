//
//  ChatViewController.swift
//  Chat
//
//  Created by Timothy Lee on 9/23/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageField: UITextField!
    var messages: [PFObject] = [PFObject]()
    
    @IBAction func onSend(sender: AnyObject) {
        var message = PFObject(className: "Message")
        message["text"] = messageField.text
        
        message.saveInBackgroundWithBlock { (result: Bool, error: NSError!) -> Void in
            self.messageField.text = nil
            self.fetchMessages()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fetchMessages", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchMessages() {
        var query = PFQuery(className: "Message")
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            self.messages = objects as [PFObject]
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as MessageCell
        
        var message = messages[indexPath.row]
        
        cell.messageLabel.text = message["text"] as? String
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
