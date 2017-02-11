//
//  TableViewCell.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 2/9/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var messagesNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCellWithTopic(topic: Topic) {
        topicNameLabel.text = topic.name
        messagesNumberLabel.text = "\(topic.messages.count)"
        
        if topic.messages.count == 0 {
            subtitleLabel.text = "No New Messages"
        } else {
            subtitleLabel.text = topic.messages.last
        }
        
        if topic.newMessages == true {
            messagesNumberLabel.textColor = UIColor.black
        } else {
            messagesNumberLabel.textColor = UIColor.darkGray
        }
    }

}
