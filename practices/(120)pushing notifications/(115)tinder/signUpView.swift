//
//  signUpView.swift
//  (115)tinder
//
//  Created by yuanzichao on 1/2/15.
//  Copyright (c) 2015 yuanzichao. All rights reserved.
//

import UIKit

class signUpView: UIViewController {
    var user = PFUser.currentUser()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var maleOrFemale: UISwitch!
    @IBAction func SignUpButton(sender: AnyObject) {
        let user = PFUser.currentUser()

        if maleOrFemale.on {
            user["interestedIn"] = "female"
        }else{
            user["interestedIn"] = "male"
        }
        user.save()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var user = PFUser.currentUser()

        var FBSession = PFFacebookUtils.session()
        var accessToken = FBSession.accessTokenData.accessToken
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large&return_ssl_resources=1&access_token="+accessToken)
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response,data,error in
            
            let image = UIImage(data: data)
            self.imageView.image = image
            
            user["image"] = data
            user.save()
            
        })
        
        FBRequestConnection.startForMeWithCompletionHandler({
            connection,result,error in
            user["name"] = result["name"]
            user["gender"] = result["gender"]
            user.save()

        })
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
