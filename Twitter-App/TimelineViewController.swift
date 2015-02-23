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
    var pullRefreshControl: UIRefreshControl!

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func signOut(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    @IBAction func composeTweet(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Compose", bundle: nil)
        let navController = storyboard.instantiateInitialViewController() as UINavigationController
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        TwitterClient.sharedInstance.timelineWithCompletion(nil, completion: {(tweets, error) -> () in
            println(tweets)
            self.tweets = tweets
            self.tableView.reloadData()
        })
        pullRefreshControl = UIRefreshControl()
        pullRefreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(pullRefreshControl, atIndex: 0)

    }
    
    
    func onRefresh() {
        TwitterClient.sharedInstance.timelineWithCompletion(nil, completion: {(tweets, error) -> () in
            println(tweets)
            self.tweets = tweets
            self.tableView.reloadData()
        })
        self.pullRefreshControl.endRefreshing()
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
        cell.handle.text = "@" + thisUser.screenname! as NSString
        cell.profileImage.setImageWithURL(NSURL(string: thisUser.profileImageURL!))
        println(thisTweet.favorite_count!)
        println(thisTweet.favorited!)
        println(thisTweet.retweet_count!)
        println(thisTweet.retweeted!)
        if thisTweet.favorited! {
            cell.favoriteImage.image = UIImage(named: "favorite-on.png")
        } else {
            cell.favoriteImage.image = UIImage(named: "favorite.png")
        }
        if thisTweet.favorite_count! > 0 {
            cell.favoriteLabel.text = "\(thisTweet.favorite_count!)"
        }
        if thisTweet.retweeted! {
            cell.retweetImage.image = UIImage(named: "retweet-on.png")
        } else {
            cell.retweetImage.image = UIImage(named: "retweet.png")
        }
        if thisTweet.retweet_count! > 0 {
            cell.retweetLabel.text = "\(thisTweet.retweet_count!)"
        }
        return cell
    }

}
