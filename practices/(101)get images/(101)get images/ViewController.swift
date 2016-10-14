//
//  ViewController.swift
//  (101)get images
//
//  Created by yuanzichao on 12/29/14.
//  Copyright (c) 2014 yuanzichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
    
    }
    
    @IBAction func PickImage(sender: AnyObject) {
        var imagePicking = UIImagePickerController()
        imagePicking.delegate = self
//        imagePicking.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicking.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicking.allowsEditing = false
        self.presentViewController(imagePicking, animated: true, completion: nil)

        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

