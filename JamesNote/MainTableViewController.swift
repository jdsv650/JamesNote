//
//  MainTableViewController.swift
//


import UIKit
import MessageUI

class MainTableViewController: UITableViewController, NoteCellDelegate, MFMailComposeViewControllerDelegate {
    
    let noteStore = NoteStore.shared()
    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    
    var cellHeights = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //view.addGestureRecognizer(tap)
        
        createCellHeightsArray()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "green-gradient2560")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // reload the height array
        createCellHeightsArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //reset this so we can determine create / edit later
        editNote = nil
    }
    
  
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...noteStore.count() {
            cellHeights.append(kCloseCellHeight)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteStore.count()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
      guard case let cell as DemoCell = cell else {
        return
      }
      
      cell.backgroundColor = UIColor.clear
      
      if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
        cell.selectedAnimation(false, animated: false, completion:nil)
      } else {
        cell.selectedAnimation(true, animated: false, completion: nil)
      }
      
      cell.number = indexPath.row
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! DemoCell
        
        // Configure the cell...
        let rowNumber = indexPath.row
        let note =  noteStore.getNote(rowNumber)
        
        cell.delegate = self
        cell.setupCell(note)
        
        return cell
    }
    
    // MARK: Cell delegate
    
    func didTapDelete(cell: UITableViewCell) {
        
        print("Tapped delete in cell")
        verifyDelete(title: "Delete Note", theMessage: "", cell: cell)
    }
    
    func verifyDelete(title: String, theMessage: String, cell: UITableViewCell)
    {
        let alert = UIAlertController(title: title, message: theMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in self.removeNote(cell: cell)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func removeNote(cell: UITableViewCell)
    {
        let theIndexPath = tableView.indexPath(for: cell)
        
        if let path = theIndexPath
        {
            self.noteStore.delete(path.row)
            //self.tableView.deleteRows(at: [path], with: .fade)
            
            for i in 0..<noteStore.count()
            {
                cellHeights[i] = kCloseCellHeight
               // cell.selectedAnimation(false, animated: true, completion: nil)
               // duration = 1.1
                
            }
            
            self.tableView.reloadData()

         
            DispatchQueue.global(qos: .background).async {
                self.noteStore.save()
            }
        }
    }
    
    
    func didTapEdit(cell: UITableViewCell) {
        
        print("tapped edit")
        editNote(cell: cell)
    }
    
    var editNote :Note?
    
    func editNote(cell: UITableViewCell)
    {
        let theIndexPath = tableView.indexPath(for: cell)
        
        if let indexP = theIndexPath  // Edit
        {
            editNote = noteStore.getNote(indexP.row)
        }
        else // Create
        {
            editNote = Note()
        }
        
        self.performSegue(withIdentifier: "editSegue", sender: self)
    }

    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[(indexPath as NSIndexPath).row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight { // open cell
            cellHeights[(indexPath as NSIndexPath).row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[(indexPath as NSIndexPath).row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! DetailViewController
        
        if let editN = editNote
        {
            nextVC.note = editN
        }
        else
        {
            nextVC.note = Note()
        }
        
    }
    
    // unwind segue
    @IBAction func saveNote(_ segue: UIStoryboardSegue)
    {
        if editNote != nil  // Edit
        {
            editNote = nil
            tableView.reloadData()
            
        } else  // Create
        {
            DispatchQueue.main.async
            {
                let noteDetail = segue.source as! DetailViewController
                //notes.append(noteDetail.note)
                self.noteStore.createNote(noteDetail.note)
            
                DispatchQueue.global(qos: .background).async {
                    self.noteStore.save()
                }
            
                print("Num notes = \(self.noteStore.count())")
            
                self.tableView.reloadData()
                // let lastRow = IndexPath(item: noteStore.count() - 1, section: 0)
                // tableView.insertRows(at: [lastRow], with: UITableViewRowAnimation.none)
            }
        }
        
    }
    
    func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    
    func didTapEmail(cell: UITableViewCell) {
        
        let mailComposeViewController = configuredMailComposeViewController(cell: cell)
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }

    }
    
    // MARK: Mail 
    func configuredMailComposeViewController(cell: UITableViewCell) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        let theIndexPath = tableView.indexPath(for: cell)
        
        var theNote :Note?
        
        if let indexP = theIndexPath  // Edit
        {
            theNote = noteStore.getNote(indexP.row)
        }
        
        if let title = theNote!.title
        {
            mailComposerVC.setSubject("\(title)")
            
        }
        
        if let message = theNote!.text
        {
            mailComposerVC.setMessageBody("\(message)", isHTML: false)
        }
        
        if let img = theNote!.image
        {
            let myData = UIImagePNGRepresentation(img)
            if myData != nil
            {
                mailComposerVC.addAttachmentData(myData!, mimeType: "image/png", fileName: "image.png")
            }
        }
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    
}
