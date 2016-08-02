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
    
    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var camera_button: UIBarButtonItem!
    
    @IBOutlet weak var album_button: UIBarButtonItem!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
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
    
    
    struct Meme {
        var topText = ""
        var bottomText = ""
        var image = UIImage()
        var memedImage = UIImage()
        
        init (topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
            self.topText = topText
            self.bottomText = bottomText
            self.image = originalImage
            self.memedImage = memedImage
        }
        
    }
    
    @IBAction func share_meme(sender: AnyObject) {
        let objectsToShare = [generateMemedImage()]
        let viewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = sender as! UIImageView   
        self.presentViewController(viewController, animated: true, completion: nil)

        
    }
    
    func save() {
        //Create the meme
        let meme = Meme( topText: topTextField.text!, bottomText:bottomTextField.text!, originalImage:imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolbar.hidden = true
        navbar.hidden = true
        camera_button.enabled = false
        album_button.enabled = false
    
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar 
        toolbar.hidden = false
        navbar.hidden = false
        camera_button.enabled = true
        album_button.enabled = true
        
        return memedImage
    }
    


}

