//
//  MessageSenderDelegate.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation
import XMPPFramework

class StreamController: NSObject {
    
    private let repository: Repository = MockRepository()
    
    private var password: String!
    private let stream = XMPPStream()
    
    var messages: [Message] = []
   
    init(jid: String, password: String, queue: DispatchQueue = DispatchQueue.main) {
        
        super.init()
        stream.addDelegate(self, delegateQueue: queue)
        stream.myJID = XMPPJID(string: jid)
        self.password = password
        
        do {
            try stream.connect(withTimeout: 30)
        }
        catch {
            print("Error occured in connecting - \(error)")
        }
    }
}

extension StreamController: XMPPStreamDelegate {
    
    func sendMessage(user: User, text: String) {
        let xmppMessage = XMPPMessage(type: "chat", to: XMPPJID(string: user.jid))
        xmppMessage.addBody(text)
        
        guard
            let senderId = repository.getCurrentUser()?.id
        else {
            print("---You is not authorized")
            return
        }
        
        let message = Message(senderId: senderId, receiverId: user.id, text: text)
        repository.saveMessage(message: message)
        stream.send(xmppMessage)
    }
    
    func xmppStreamWillConnect(sender: XMPPStream!) {
        print("Will connect")
    }
    
    func xmppStreamConnectDidTimeout(_ sender: XMPPStream) {
        print("Timeout")
    }
    
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        
        print("Connected")
        
        try? sender.authenticate(withPassword: self.password)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        print("Auth done")
        sender.send(XMPPPresence())
    }
    
    func xmppStream(_ sender: XMPPStream, didReceive message: XMPPMessage) {
        
        guard
            let jid = sender.myJID?.full,
            let user = repository.getUserByJID(jid: jid),
            let text = message.body
        else {
            return
        }
        let msg = Message(senderId: user.id, receiverId: 0, text: text)
        repository.saveMessage(message: msg)
    }
}
