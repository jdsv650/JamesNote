//
//  Note.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.

import UIKit

class Note : NSObject, NSCoding
{
    var title :String?
    var text :String?
    var date :Date? = Date()
    var image : UIImage?
    
    override init()
    {
        //image = UIImage(named: "Solid_white.png")!
        super.init()
    }
    
    var shortDate : NSString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        if let theDate = date
        {
            return dateFormatter.string(from: theDate) as NSString
        }
        
        return ""
    }
    
    var shortTime : NSString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone.local

        if let theDate = date
        {
            return dateFormatter.string(from: theDate) as NSString
        }
        
        return ""
    }
    
    func encode(with aCoder: NSCoder)  // to string
    {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(image, forKey: "image")
        

    }
    
    required init?(coder aDecoder: NSCoder)  // back to required type
    {
        
       // title = aDecoder.decodeObject(forKey: "title") as! String
       // text = aDecoder.decodeObject(forKey: "text") as! String
       // date = aDecoder.decodeObject(forKey: "date") as! Date
       // image = aDecoder.decodeObject(forKey: "image") as? UIImage
        
        
        if let theTitle = aDecoder.decodeObject(forKey: "title") as? String
        {
            title = theTitle
        }
        
        if let theText = aDecoder.decodeObject(forKey: "text") as? String
        {
            text = theText
        }
        
        if let theDate = aDecoder.decodeObject(forKey: "date") as? Date
        {
            date = theDate
        }
        
        if let img = aDecoder.decodeObject(forKey: "image") as? UIImage
        {
            image = img
        }
     
    }
    
    
}






