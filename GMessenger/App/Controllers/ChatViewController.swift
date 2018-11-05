//
//  ViewController.swift
//  GMessenger
//
//  Created by Артем Полушин on 27.10.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import UIKit
import XMPPFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let cellId = "messageCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    let stream = StreamController(jid: "justeryoda@jabber.mipt.ru", password: "^vUttC^%6gHFh5")
    
    let repository: Repository = MockRepository()

    let textField = UITextField()
    
    @IBAction func say(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }

    @objc func sendMessage() {
//        guard
//            let text = textField.text
//        else {
//            print("---Text is empty")
//            return
//        }
//
//        if let receiver = repository.getUserByJID(jid: "justervader@jabber.mipt.ru") {
//            stream.sendMessage(user: receiver, text: text)
//        } else {
//            stream.sendMessage(user: User(name: "justervader@jabber.mipt.ru", jid: "justervader@jabber.mipt.ru"),
//                               text: text)
//        }
//
//        textField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
      //  cell.textLabel?.text = "A very common task in iOS is to provide auto sizing cells for UITableView components. In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints."
        
        
        return cell
    }
}

