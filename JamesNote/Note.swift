//
//  Note.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

class Note : NSObject, NSCoding
{
    var title = ""
    var text = ""
    var date = NSDate()
    
    override init()
    {
        super.init()
    }
    
    var shortDate : NSString {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.stringFromDate(date)
    }
    
    func encodeWithCoder(aCoder: NSCoder)  // to string
    {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(text, forKey: "text")
        aCoder.encodeObject(date, forKey: "date")
    }
    
    required init(coder aDecoder: NSCoder)  // back to required type
    {
        title = aDecoder.decodeObjectForKey("title") as String
        text = aDecoder.decodeObjectForKey("text") as String
        date = aDecoder.decodeObjectForKey("date") as NSDate
    }
    
    
}






