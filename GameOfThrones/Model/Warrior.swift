//
//  Warrior.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Warrior: Codable {
    let name: String
    let surname: String
    let currency: Currency
    let birthdate: Date
}

extension Warrior: Equatable {
    public static func == (lhs: Warrior, rhs: Warrior) -> Bool {
        return lhs.name == rhs.name && lhs.surname == rhs.surname
    }
}
