//
//  AboutViewController.swift
//  JamesNote
//
//  Created by James on 2/16/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit
import StoreKit

class AboutViewController: UIViewController, SKStoreProductViewControllerDelegate {

    @IBOutlet weak var viewOnStoreButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    var storeVC: SKStoreProductViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewOnStoreButton.layer.cornerRadius = 10
        viewOnStoreButton.layer.borderColor = UIColor.white.cgColor
        viewOnStoreButton.layer.borderWidth = 2
        viewOnStoreButton.layer.masksToBounds = true
        
        
    }

    @IBAction func viewOnStorePressed(_ sender: UIButton)
    {
        storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        storeVC.view.tintColor = UIColor.black
        
        //  storeVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        //  storeVC.popoverPresentationController?.sourceView = sender
        //  storeVC.popoverPresentationController?.sourceRect = sender.bounds
        
        let productParams = [ SKStoreProductParameterITunesItemIdentifier : "627908713" ]   // id for all my apps
        
        storeVC.loadProduct(withParameters: productParams) { (result, error) in
            
            print("IN Load Products")
            
            if result == true
            {
                print("IN Load Products calling present")
                self.present(self.storeVC, animated: true, completion: nil)
            }
            else
            {
                print("IN Load Products app info not found")
                self.showUserMessage(title: "App info not found", theMessage: "Please try again later")
            }
            
        }
        
        
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    func showUserMessage(title: String, theMessage: String)
    {
        let alert = UIAlertController(title: title, message: theMessage, preferredStyle: UIAlertControllerStyle.actionSheet)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }


}
