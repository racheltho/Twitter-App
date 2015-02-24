//
//  TwitterClient.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/18/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

let twitterConsumerKey = CONSUMER_KEY
let twitterConsumerSecret = CONSUMER_SECRET

let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance =  TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func postTweet(params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("posted tweet")
            completion(error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("error tweeting")
            completion(error: error)
        }
    )}
    
    func favoriteTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        println("favoriteTweet called")
        println(id)
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("favorite")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error favoriting")
                completion(error: error)
            }
        )}

    
    func retweetTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        println("retweetTweet called")
        println(id)
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("retweet")
            completion(error: nil)
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error retweeting")
                completion(error: error)
        }
    )}

    func timelineWithCompletion(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> () ) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("inside Timeline with Completion")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline")
                completion(tweets: nil, error: error)
        })

    }
   
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        // Fetch request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) { (error: NSError!) -> Void in
            println("Failed to get request token")
            self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL){
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "Post", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var user = User(dictionary: response as NSDictionary)
                User.currentUser = user
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
                    }) { (error: NSError!) -> Void in
            println("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }
    }

}
