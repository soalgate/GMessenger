//
//  Result.swift
//  GMessenger
//
//  Created by Admin on 08/11/2018.
//  Copyright © 2018 Артем Полушин. All rights reserved.
//

import Foundation
enum Result<Value> {
    case success(Value)
    case failure(Error)
}
