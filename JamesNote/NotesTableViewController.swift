//
//  NotesTableViewController.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    let noteStore = NoteStore.shared()
    
   // var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var theNoteStore = NoteStore.shared()
        
//        var n1 = Note()
//        n1.image = UIImage(named: "back.png")!
//        n1.title  = "dwdqwdd"
//        n1.text = "wdwww"
//        
//        noteStore.createNote(n1)
//        noteStore.save()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteStore.count()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteDetailCell", forIndexPath: indexPath) as NoteDetailTableViewCell

        // Configure the cell...
        let rowNumber = indexPath.row
        let note =  noteStore.getNote(rowNumber)
        
        cell.setupCell(note)

        return cell
    }

    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let noteDetail = segue.destinationViewController as DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow()
        {
            noteDetail.note = noteStore.getNote(indexPath.row)

        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
           // notes.removeAtIndex(indexPath.row)
            noteStore.delete(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }

    
    // unwind segue 
    @IBAction func saveNote(segue: UIStoryboardSegue)
    {
        if let indexPath = tableView.indexPathForSelectedRow()  {
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            
        } else
        {
            let noteDetail = segue.sourceViewController as DetailViewController
          //  notes.append(noteDetail.note)
            noteStore.createNote(noteDetail.note)
            
            let lastRow = NSIndexPath(forItem: noteStore.count() - 1, inSection: 0)
            
            tableView.insertRowsAtIndexPaths([lastRow], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

}
