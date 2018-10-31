//
//  ViewController.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import UIKit
import XMPPFramework

class ViewController: UIViewController {
    
    let streamManager = StreamManager()
    
    var stream: XMPPStream!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stream = streamManager.stream(jid: "justeryoda@jabber.mipt.ru",
                                      password: "^vUttC^%6gHFh5")
        
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("SendMessage", for: .normal)
        button.frame = CGRect(x: 90, y: 100, width: 300, height: 40)
        button.addTarget(self, action: #selector(self.sendMessage), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    @objc func sendMessage() {
        let msg = XMPPMessage(type: "chat", to: XMPPJID(string: "justervader@jabber.mipt.ru"))
        msg.addBody("Test message")
        stream.send(msg)
    }
}

