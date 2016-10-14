//
//  PostViewController.swift
//  (105)login and sign up
//
//  Created by yuanzichao on 12/31/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit


class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photoSelected = false
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func ChooseImage(sender: AnyObject) {
        let image  = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated:true,completion:nil)
        
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func PostThisImage(sender: AnyObject) {
        var activityIndicator:UIActivityIndicatorView
        var error = ""
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
       
        if photoSelected != true{
            error = "Please select a photo"
        }else if textField.text == "" {
            error = "Plese enter a message"
        }
        
        if error != "" {
            activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            displayErrorByAlert("Sorry",error: error)
            
        }else{
            var post = PFObject(className: "Post")
            post["title"] = textField.text
            post["username"] = PFUser.currentUser().username
            
            post.saveInBackgroundWithBlock{(success:Bool! , error:NSError! ) -> Void in
                if success == false{
                self.displayErrorByAlert("Sorry",error: "please try again later")
                }else{
                
                    let imageData = UIImagePNGRepresentation(self.imageView.image)
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    post["imageFile"] = imageFile
                    
                    post.save()
//                    println("succeed")
                    activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayErrorByAlert("Succeed", error: "Your image has been posted successfully")
                    self.resetEverything()
                }
            }
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        print("selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
        
        photoSelected = true
    }
    
    func displayErrorByAlert(title:NSString,error:NSString){
        var alert = UIAlertController(title: title as String, message: error as String, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       resetEverything()
    }
    
    func resetEverything(){
         photoSelected = false
        imageView.image = UIImage(named: "placehoder(man).jpg")
        textField.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
