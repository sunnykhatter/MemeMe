//
//  ViewController.swift
//  Memerr
//
//  Created by Lakshay Khatter on 7/19/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!

    @IBOutlet weak var bottomTextField: UITextField!
    
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)!,
            NSStrokeWidthAttributeName : -2.0,
            
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.adjustsFontSizeToFitWidth = true
        topTextField.textAlignment = NSTextAlignment.Center
        
        
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.adjustsFontSizeToFitWidth = true
        bottomTextField.textAlignment = NSTextAlignment.Center
    
        topTextField.hidden = true
        bottomTextField.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePickerView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
        topTextField.hidden = false
        bottomTextField.hidden = false
    }

}

