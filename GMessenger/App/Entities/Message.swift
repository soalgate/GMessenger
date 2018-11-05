//
//  Message.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation

class Message {
    var id: String
    var senderId: UInt64
    var receiverId: UInt64
    var text: String
    
    init(id: String = "", senderId: UInt64, receiverId: UInt64, text: String) {
        self.id = id
        self.senderId = senderId
        self.receiverId = receiverId
        self.text = text
    }
}
