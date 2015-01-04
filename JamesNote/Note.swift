//
//  Note.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

class Note
{
    var title = ""
    var text = ""
    var date = NSDate()
    
    var shortDate : NSString {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.stringFromDate(date)
    }
    
}






