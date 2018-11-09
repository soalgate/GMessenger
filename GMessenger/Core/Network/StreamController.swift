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
    
    func sendMessage(message: Message) {
        guard
            case .success(let value) = repository.getUserById(id: message.receiverId),
            let receiver = value
            else {
                return
        }
        
        let xmppMessage = XMPPMessage(type: "chat", to: XMPPJID(string: receiver.jid))
        xmppMessage.addBody(message.text)
        
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
        
        let msg = Message(senderId: 1, receiverId: 0, text: message.body!)
        
        NotificationCenter.default.post(name: Notification.Name("New message"), object: nil, userInfo: ["message" : msg])
    }
}
