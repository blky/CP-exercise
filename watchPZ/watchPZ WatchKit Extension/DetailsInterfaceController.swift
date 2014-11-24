//
//  DetailsInterfaceController.swift
//  watchPZ
//
//  Created by Cindy Zheng on 11/23/14.
//  Copyright (c) 2014 Cindy Z. All rights reserved.
//

import WatchKit

class DetailsInterfaceController: WKInterfaceController {
    @IBOutlet weak var labelDetail: WKInterfaceLabel!
    
    override init(context: AnyObject?) {
        super.init(context: context)
        
        if  let answer = context  as? String   {
            self.labelDetail.setText(answer)
        }
        
    }
   
}
