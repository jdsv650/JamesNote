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
    var date = Date()
    var image : UIImage
    
    override init()
    {
        image = UIImage(named: "Solid_white.png")!
        super.init()
    }
    
    var shortDate : NSString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: date) as NSString
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
        title = aDecoder.decodeObject(forKey: "title") as! String
        text = aDecoder.decodeObject(forKey: "text") as! String
        date = aDecoder.decodeObject(forKey: "date")as! Date
        
        if let img = aDecoder.decodeObject(forKey: "image") as? UIImage
        {
            image = img
        }
        else
        {
            image = UIImage(named: "Solid_white.png")!
        }
        
       

    }
    
    
}






