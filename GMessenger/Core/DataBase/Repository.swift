//
//  DataBase.swift
//  GMessenger
//
//  Created by Артем Полушин on 04.11.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation

protocol Repository {
    
    func getUsers() -> Result<[User]>
    func getUserById(id: Int64) -> Result<User?>
    func getUserByJID(jid: String) -> Result<User?>
    func getCurrentUser() -> Result<User?>
    func getMessages() -> Result<[Message]>
    func getMessage(id: String) -> Result<Message?>
    func saveUser(user: User) -> Result<User>
    func saveMessage(message: Message) -> Result<Message>
}
