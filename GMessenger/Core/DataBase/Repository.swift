//
//  DataBase.swift
//  GMessenger
//
//  Created by Артем Полушин on 04.11.2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation

protocol Repository {
    
    func getUsers() -> [User]
    func getUserById(id: UInt64) -> User?
    func getUserByJID(jid: String) -> User?
    func getCurrentUser() -> User?
    func getMessages() -> [Message]
    func getMessage(id: String) -> Message?
    func saveUser(user: User) -> User
    func saveMessage(message: Message)
}
