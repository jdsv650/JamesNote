//
//  Note.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
// /http://bit.ly/12iTnxS

import UIKit

class Note : NSObject, NSCoding
{
    var title = ""
    var text = ""
    var date = NSDate()
    var image : UIImage
    
    override init()
    {
        image = UIImage(named: "Solid_white.png")!
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
        aCoder.encodeObject(image, forKey: "image")
        

    }
    
    required init(coder aDecoder: NSCoder)  // back to required type
    {
        title = aDecoder.decodeObjectForKey("title") as String
        text = aDecoder.decodeObjectForKey("text") as String
        date = aDecoder.decodeObjectForKey("date") as NSDate
        image = aDecoder.decodeObjectForKey("image") as UIImage
        
        
       

    }
    
    
}






