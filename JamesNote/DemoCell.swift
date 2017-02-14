//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import UIKit

class DemoCell: FoldingCell {
  
    
    // closed outlets
    @IBOutlet weak var closedTitle: UILabel!
    @IBOutlet weak var closedText: UILabel!
    @IBOutlet weak var closedDate: UILabel!
    @IBOutlet weak var closedTime: UILabel!
    @IBOutlet weak var closedImage: UIImageView!
    
    // open outlets
    @IBOutlet weak var openTitle: UILabel!
    @IBOutlet weak var openText: UITextView!
    
    @IBOutlet weak var openMapView: UIView!
    @IBOutlet weak var openImage: UIImageView!
    
    @IBOutlet weak var openLocationDesc: UILabel!
    
  
  var number: Int = 0 {
    didSet {
    //  openNumberLabel.text = String(number)
    }
  }
  override func awakeFromNib() {
    
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    
    closedTitle.layer.cornerRadius = 10
    closedText.layer.cornerRadius = 10
    closedText.layer.masksToBounds = true
    openTitle.layer.cornerRadius = 10
    openText.layer.cornerRadius = 10
    openText.layer.masksToBounds = true
    openMapView.layer.cornerRadius = 10
    
    super.awakeFromNib()
  }
  
  override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
    
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
    
    @IBAction func deletePressed(_ sender: UIButton)
    {
        
    }
    
    
}

// MARK: Actions
extension DemoCell {
    

  
  @IBAction func buttonHandler(_ sender: AnyObject) {
    print("tap")
  }
    
    
    
    
    
}
