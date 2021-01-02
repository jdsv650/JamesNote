//
//  DetailViewController.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate
{
    var imagePicker = UIImagePickerController()
    var note: Note = Note()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var isPlaceHolderImage = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "green-gradient2560")!)
        
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 2

        textField.text = note.title
        textView.text = note.text
        if let img = note.image
        {
            imageView.image = img
            isPlaceHolderImage = false
        }
        else
        {
            isPlaceHolderImage = true
        
            if let placeholderImg = UIImage(named: "Placeholder.png")
            {
                imageView.image = placeholderImg
            }
        }

       // textView.becomeFirstResponder()
        
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        
        textField.delegate = self
        textView.delegate = self
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
          
          if let theImage = img
          {
              note.image = theImage
              imageView.image = theImage
              isPlaceHolderImage = false
          }
          
          self.dismiss(animated: true, completion: nil)
    }
        
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
           self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraPressed(_ sender: AnyObject) {
        
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear)
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraDevice = UIImagePickerController.CameraDevice.rear
        }
        else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front)
        
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraDevice = UIImagePickerController.CameraDevice.front
        }
        else  // no camera
        {
            let alert = UIAlertController(title: "Camera Not Found", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        // for screenshots
        //imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
   
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let theTitle = textField.text
        {
            note.title = theTitle
        }
        
        if let theText = textView.text
        {
            note.text = theText
        }
        
        if isPlaceHolderImage == false   // don't save placeholder image
        {
            if let img = imageView.image
            {
                note.image = img
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
