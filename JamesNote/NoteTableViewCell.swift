//
//  NoteTableViewCell.swift
//  JamesNote
//
//  Created by James on 2/13/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class NoteTableViewCell: FoldingCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteText: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
   
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        noteTitle.layer.cornerRadius = 10
        noteDate.layer.cornerRadius = 10
        noteImageView.layer.cornerRadius = 10
        
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    func setupCell(_ theNote: Note)
    {
        noteTitle.text = theNote.title
        noteText.text = theNote.text
        noteDate.text = theNote.shortDate as String
        // if let img = theNote.image
        // {
        noteImageView.image = theNote.image
        // }
    }
    


}
