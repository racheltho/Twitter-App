//
//  TweetCell.swift
//  Twitter-App
//
//  Created by Rachel Thomas on 2/20/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var tweet: Tweet!
    
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
