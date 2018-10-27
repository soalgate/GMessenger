//
//  AbstractContact.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation

class AbstractContact {
    var id: UInt64
    var name: String
    var users: [UInt64] = []
    var messages: [String] = []
    
    init(id: UInt64, name: String) {
        self.id = id
        self.name = name
    }
}
