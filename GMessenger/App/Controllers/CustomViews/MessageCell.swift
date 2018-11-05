//
//  MessageCell.swift
//  GMessenger
//
//  Created by Артем Полушин on 05.11.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(messageLabel)
        messageLabel.backgroundColor = Style.Color.mainBlueColor
        messageLabel.numberOfLines = 0
        
        messageLabel.text = "A very common task in iOS is to provide auto sizing cells for UITableView components. In today's lesson we look at how to implement a custom cell that provides auto sizing using anchor constraints."
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                           messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                           messageLabel.widthAnchor.constraint(equalToConstant: 250)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
