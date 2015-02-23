//
//  ComposerViewController.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/22/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class ComposerViewController: UIViewController {
    
    var currentUser: User?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var status: UITextView!
    
    func returnToTimeline(){
        let storyboard = UIStoryboard(name: "Timeline", bundle: nil)
        let navController = storyboard.instantiateInitialViewController() as UINavigationController
        self.presentViewController(navController, animated: true, completion: nil)

    }

    @IBAction func sendTweet(sender: AnyObject) {
        var params = NSDictionary()
        println("inside sendTweet")
        params = ["status" : status.text!]
        println(params)
        TwitterClient.sharedInstance.postTweet(params, completion: {(error) -> () in
            println("success!")
            self.returnToTimeline()
        })
    }
    
    @IBAction func cancelTweet(sender: AnyObject) {
       returnToTimeline()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser =  User.currentUser
        profileImage.setImageWithURL(NSURL(string: currentUser!.profileImageURL!))
        name.text = currentUser!.name!
        handle.text = "@\(currentUser!.screenname!)"
        println("made it here")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
