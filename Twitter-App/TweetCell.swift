//
//  TweetCell.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/20/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

protocol TweetCellReplyDelegate : class {
    func reply(tweetCell: TweetCell)
}

protocol TweetCellRetweetDelegate : class {
    func retweet(tweetCell: TweetCell)
}

protocol TweetCellFavoriteDelegate : class {
    func favorite(tweetCell: TweetCell)
}

class TweetCell: UITableViewCell {

    var tweet: Tweet!
    
    weak var replyDelegate: TweetCellReplyDelegate?
    weak var retweetDelegate: TweetCellRetweetDelegate?
    weak var favoriteDelegate: TweetCellFavoriteDelegate?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    @IBAction func replyAction(sender: AnyObject) {
        replyDelegate?.reply(self)
    }
    
    @IBAction func retweetAction(sender: AnyObject) {
        retweetDelegate?.retweet(self)
    }
    
    @IBAction func favoriteAction(sender: AnyObject) {
        favoriteDelegate?.favorite(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tweetText.preferredMaxLayoutWidth = tweetText.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetText.preferredMaxLayoutWidth = tweetText.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
