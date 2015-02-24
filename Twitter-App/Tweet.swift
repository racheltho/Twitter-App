//
//  Tweet.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/19/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var id: Int?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var favorite_count: Int?
    var favorited: Bool?
    var retweet_count: Int?
    var retweeted: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        favorite_count = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweet_count = dictionary["retweet_count"] as? Int
        retweeted = dictionary["retweeted"] as? Bool
        id = dictionary["id"] as? Int
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
    
}
