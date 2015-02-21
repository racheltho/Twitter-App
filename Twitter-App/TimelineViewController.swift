//
//  TimelineViewController.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/20/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource {
    
    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func signOut(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        TwitterClient.sharedInstance.timelineWithCompletion(nil, completion: {(tweets, error) -> () in
            println(tweets)
            self.tweets = tweets
            println("made it here")
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        if let array = tweets {
            println(array.count)
            return array.count
        } else {
            println("zero")
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetcell") as TweetCell
        let thisTweet = tweets![indexPath.row] as Tweet
        let thisUser = thisTweet.user! as User
        cell.tweet = thisTweet
        println(thisTweet.text!)
        println(thisTweet.user!.name!)
        cell.tweetText.text = thisTweet.text! as NSString
        cell.name.text = thisUser.name! as NSString
        cell.handle.text = thisUser.screenname! as NSString
        cell.profileImage.setImageWithURL(NSURL(string: thisUser.profileImageURL!))
        return cell
    }

}
