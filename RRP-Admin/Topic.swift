//
//  Topic.swift
//  RRP-Admin
//
//  Created by Zack Spicer on 2/9/17.
//  Copyright © 2017 Zack Spicer. All rights reserved.
//

import Foundation

class Topic : NSObject, NSCoding {
    
    let name: String
    var messages: [String]
    let newMessages: Bool
    
    init(name: String) {
        self.name = name
        messages = []
        newMessages = false
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.messages = aDecoder.decodeObject(forKey: "messages") as! [String]
        self.newMessages = aDecoder.decodeBool(forKey: "newMessages")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(messages, forKey: "messages")
        aCoder.encode(newMessages, forKey: "newMessages")
    }
}
