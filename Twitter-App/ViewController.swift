//
//  ViewController.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/17/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?, error: NSError?) in
            if user != nil {
                let storyboard = UIStoryboard(name: "Timeline", bundle: nil)
                let navController = storyboard.instantiateInitialViewController() as UINavigationController
                self.presentViewController(navController, animated: true, completion: nil)
            } else {
                //handle error
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

