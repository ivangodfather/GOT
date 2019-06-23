//
//  WarriorService.swift
//  
//
//  Created by Ivan Ruiz Monjo on 19/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

protocol WarriorServiceProtocol {
    func saveWarrior(_ warrior: Warrior)
    func currentWarrior() -> Warrior?
}

final class WarriorService: WarriorServiceProtocol {
    
    private let databaseProvider: DatabaseProviderProtocol
    
    init(databaseProvider: DatabaseProviderProtocol = DatabaseProvider()) {
        self.databaseProvider =  databaseProvider
    }
    
    func saveWarrior(_ warrior: Warrior) {
        return databaseProvider.saveWarrior(warrior)
    }
    
    func currentWarrior() -> Warrior? {
        return databaseProvider.currentWarrior()
    }
    
}
