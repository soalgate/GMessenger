//
//  DataRepository.swift
//  GMessenger
//
//  Created by Admin on 08/11/2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation

class DataRepository: Repository {
    var dataBase = CoreDataManager.shared
    
    func getUsers() -> Result<[User]> {
        do {
            let result = try dataBase.getEntitys(entityType: User.self, with: nil)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func getUserById(id: Int64) -> Result<User?> {
        let predicate = NSPredicate(format: "%K = %@", "id", id)
        do {
            let result = try dataBase.getEntitys(entityType: User.self, with: predicate)
            return .success((result.count) == 1 ? result[0] : nil) // Если будет несколько пользователей с одним ид :
            //возвращаем первого попавшегося,
            //ошибку
            //просто нил ?
        } catch {
            return .failure(error)
        }
    }
    
    func getUserByJID(jid: String) -> Result<User?> {
        let predicate = NSPredicate(format: "%K = %@", "jid", jid)
        do {
            let result = try dataBase.getEntitys(entityType: User.self, with: predicate)
            return .success((result.count) == 1 ? result[0] : nil) // Если будет несколько пользователей с одним ид :
            //возвращаем первого попавшегося,
            //ошибку
            //просто нил ?
        } catch {
            return .failure(error)
        }
    }
    
    func getCurrentUser() -> Result<User?> {
        let predicate = NSPredicate(format: "%K = %@", "isAuthorized", true)
        do {
            let result = try dataBase.getEntitys(entityType: User.self, with: predicate)
            return .success((result.count) == 1 ? result[0] : nil) // Если будет несколько пользователей :
            //возвращаем первого попавшегося,
            //ошибку
            //просто нил ?
        } catch {
            return .failure(error)
        }
    }
    
    func getMessages() -> Result<[Message]> {
        do {
            let result = try dataBase.getEntitys(entityType: Message.self, with: nil)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func getMessage(id: String) -> Result<Message?> {
        let predicate = NSPredicate(format: "%K = %@", "id", id)
        do {
            let result = try dataBase.getEntitys(entityType: Message.self, with: predicate)
            return .success((result.count) == 1 ? result[0] : nil) // Если будет несколько :
            //возвращаем первого попавшегося,
            //ошибку
            //просто нил ?
        } catch {
            return .failure(error)
        }
    }
    
    func saveUser(user: User) -> Result<User> {
        do {
            _ = try dataBase.saveContext()
            return .success(user)
        } catch {
            return .failure(error)
        }
        
    }
    
    func saveMessage(message: Message) -> Result<Message> {
        do {
            _ = try dataBase.saveContext()
            return .success(message)
        } catch {
            return .failure(error)
        }
    }
    
}
