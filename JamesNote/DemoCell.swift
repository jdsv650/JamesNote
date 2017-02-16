//
//  DemoCell.swift
//  FoldingCell
//

import UIKit

protocol NoteCellDelegate {
    func didTapDelete(cell: UITableViewCell)
    func didTapEdit(cell: UITableViewCell)
}


class DemoCell: FoldingCell {
    
    var delegate :NoteCellDelegate?
  
    
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
        
        closedImage.layer.cornerRadius = 10
        closedImage.layer.masksToBounds = true
        openImage.layer.cornerRadius = 10
        openImage.layer.masksToBounds = true
    
        super.awakeFromNib()
    }
  
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
    
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    @IBAction func deletePressed(_ sender: UIButton)
    {
        delegate?.didTapDelete(cell: self)
    }
    
    func setupCell(_ theNote: Note)
    {
        if let theTitle = theNote.title
        {
            closedTitle.text = theTitle
            openTitle.text = theTitle
        }
        
        if let theText = theNote.text
        {
            closedText.text = theText
            openText.text = theNote.text
        }
       
        if let img = theNote.image
        {
            closedImage.image = img
            openImage.image = img
        }
        else
        {
            closedImage.image = UIImage(named: "Placeholder")
            openImage.image = UIImage(named: "Placeholder")
        }
        
        closedDate.text = theNote.shortDate as String
        closedTime.text = theNote.shortTime as String
        
      
    }

    
    
}

// MARK: Actions
extension DemoCell {
  
  @IBAction func buttonHandler(_ sender: AnyObject) {
    print("tap")
    delegate?.didTapEdit(cell: self)
 }
    
    
    
    
    
}
