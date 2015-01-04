//
//  NoteDetailTableViewCell.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

class NoteDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteText: UILabel!

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupCell(theNote: Note)
    {
        noteTitle.text = theNote.text
        noteText.text = theNote.title
        noteDate.text = theNote.shortDate
        
    }


}
