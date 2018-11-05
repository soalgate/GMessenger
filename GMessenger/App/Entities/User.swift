//
//  User.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation

class User: AbstractContact {
    var jid: String = ""
    var isAuthorized: Bool = false
    var groups: [UInt64] = []
    
    init(id: UInt64 = 0, name: String, jid: String) {
        super.init(id: id, name: name)
        self.jid = jid
    }
}
