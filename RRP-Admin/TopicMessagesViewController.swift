//
//  TopicMessagesViewController.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 2/11/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import UIKit

class TopicMessagesViewController: UIViewController {

    var topic: Topic?
    
    @IBOutlet weak var topicNameTextField: UITextField!
    @IBOutlet weak var topicMessagesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let t = self.topic {
            topicNameTextField.text = t.name
            for message in t.messages {
                topicMessagesTextView.text = message
            }
        }
    }
}
