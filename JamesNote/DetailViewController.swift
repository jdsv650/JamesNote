//
//  DetailViewController.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate
{
    var imagePicker = UIImagePickerController()
    var note: Note = Note()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textField.text = note.title
        textView.text = note.text
        
        if let img = note.image
        {
            imageView.image = img
        }
        textView.becomeFirstResponder()
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        
        textField.delegate = self
        textView.delegate = self
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
          note.image = img
         imageView.image = img
        }
        else
        {
            note.image = nil
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
           self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func cameraPressed(sender: AnyObject) {
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
     
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        note.text = textView.text
        note.title = textField.text
        note.image = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
