//
//  NotesTableViewController.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    var notes = [Note]()
    var message = ["Cat", "Dog", "Mountain Dew" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var james = Note()
        james.title = "James"
        james.text = "Me"
        
        var devin = Note()
        devin.title = "Devin"
        devin.text = "son"
        
        var tucker = Note()
        tucker.title = "Tucker"
        tucker.text = "son"
        
        //notes.append(james)
        // notes.append(devin)
        // notes.append(tucker)
        notes = [james, devin, tucker]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteDetailCell", forIndexPath: indexPath) as NoteDetailTableViewCell

        // Configure the cell...
        let rowNumber = indexPath.row
        let note = notes[rowNumber]
        
        cell.setupCell(note)
        
        if indexPath.section == 1
        {
       //     cell.textLabel?.text = notes[rowNumber].title
       //     cell.imageView?.image = UIImage(named: "back.png")
        }
        
        if indexPath.section == 2
        {
        //    cell.textLabel?.text = message[indexPath.row]
        }
        
        

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Person"
        // case 0
        default:
            return "Likes"
    
        }
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
