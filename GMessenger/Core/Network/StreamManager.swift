//
//  MessageSenderDelegate.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation
import XMPPFramework

class StreamManager {
    
    var password: String!
   
    func stream(jid: String, password: String) -> XMPPStream {
        
        let stream = XMPPStream()
        stream.addDelegate(self, delegateQueue: DispatchQueue.main)
        stream.myJID = XMPPJID(string: jid)
        self.password = password
        
        do {
            try stream.connect(withTimeout: 30)
        }
        catch {
            print("Error occured in connecting - \(error)")
        }
        
        return stream
    }
}

extension StreamManager: XMPPStreamDelegate {
    
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
        print(message.body!)
    }
}
