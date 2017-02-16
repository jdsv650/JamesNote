//
//  DetailViewController.swift
//  JamesNote
//
//  Created by James on 1/4/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate
{
    var imagePicker = UIImagePickerController()
    var note: Note = Note()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var isPlaceHolderImage = true
    
    
    @IBAction func sendReceiptEmailPressed(_ sender: UIBarButtonItem) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        if let title = textField.text
        {
            mailComposerVC.setSubject("\(title)")

        }
        
        if let message = textView.text
        {
            mailComposerVC.setMessageBody("\(message)", isHTML: false)
        }
        
        if let img = note.image
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        if let theImage = img
        {
            note.image = theImage
            imageView.image = theImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
           self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraPressed(_ sender: AnyObject) {
        
        
        if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.rear
        }
        else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front)
        
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front
        }
        else  // no camera
        {
            let alert = UIAlertController(title: "Camera Not Found", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            return
            
            
            //for screenshots
           // imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
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
