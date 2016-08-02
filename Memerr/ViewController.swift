//
//  ViewController.swift
//  Memerr
//
//  Created by Lakshay Khatter on 7/19/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate  {

    @IBOutlet weak var topTextField: UITextField!

    @IBOutlet weak var bottomTextField: UITextField!

    let textField = UITextField()
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        topTextField.delegate = self
        bottomTextField.delegate = self

        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)!,
            NSStrokeWidthAttributeName : -2.0]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.adjustsFontSizeToFitWidth = true
        topTextField.textAlignment = NSTextAlignment.Center
        
        
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.adjustsFontSizeToFitWidth = true
        bottomTextField.textAlignment = NSTextAlignment.Center
        subscribeToKeyboardNotifications()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if bottomTextField.editing {
            textField.resignFirstResponder()
            self.view.frame.origin.y = 0;
            
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self,name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification) -> Void{
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = -1 * getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
         view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePickerView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
    }

}

