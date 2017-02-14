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
   
  //      var theNoteStore = NoteStore.shared()
        
//        var n1 = Note()
//        n1.image = UIImage(named: "back.png")!
//        n1.title  = "dwdqwdd"
//        n1.text = "wdwww"
//        
//        noteStore.createNote(n1)
//        noteStore.save()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noteStore.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteDetailCell", for: indexPath) as! NoteDetailTableViewCell

        // Configure the cell...
        let rowNumber = indexPath.row
        let note =  noteStore.getNote(rowNumber)
        
        cell.setupCell(note)

        return cell
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let noteDetail = segue.destination as! DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            noteDetail.note = noteStore.getNote(indexPath.row)

        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // Delete the row from the data source
           // notes.removeAtIndex(indexPath.row)
            noteStore.delete(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }

    
    // unwind segue 
    @IBAction func saveNote(_ segue: UIStoryboardSegue)
    {
        if let indexPath = tableView.indexPathForSelectedRow  {
            
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            
        } else
        {
            let noteDetail = segue.source as! DetailViewController
          //  notes.append(noteDetail.note)
            noteStore.createNote(noteDetail.note)
            
            let lastRow = IndexPath(item: noteStore.count() - 1, section: 0)
            
            tableView.insertRows(at: [lastRow], with: UITableViewRowAnimation.automatic)
        }
    }

}
