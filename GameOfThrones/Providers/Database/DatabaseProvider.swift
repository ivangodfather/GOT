//
//  DatabaseProvider.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

final class DatabaseProvider: DatabaseProviderProtocol {
    
    private struct Keys {
        static let warrior = "WARRIOR"
        static let savedCurrencies = "SAVED_CURRENCIES"
        static let lastCurrencyUpdate = "LAST_CURRENCY_UPDATE"
    }
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    
    func saveWarrior(_ warrior: Warrior) {
        let data = warrior.data()
        userDefaults.setValue(data, forKey: Keys.warrior)
        userDefaults.synchronize()
    }
    
    func currentWarrior() -> Warrior? {
        guard let data = userDefaults.data(forKey: Keys.warrior) else { return nil }
        return try? JSONDecoder().decode(Warrior.self, from: data) as Warrior
    }
    
    func savedCurrencies() -> Set<SavedCurrency> {
        guard let data = userDefaults.data(forKey: Keys.savedCurrencies) else { return [] }
        return (try? JSONDecoder().decode(Set<SavedCurrency>.self, from: data) as Set<SavedCurrency>) ?? Set<SavedCurrency>()
    }
    
    func saveCurrencies(_ currencies: Set<SavedCurrency>) {
        let data = currencies.data()
        userDefaults.set(data, forKey: Keys.savedCurrencies)
        userDefaults.synchronize()
    }
    
    func lastCurrencyUpdate() -> Date? {
        return userDefaults.object(forKey: Keys.lastCurrencyUpdate) as? Date
    }
    
    func updateCurrencyDate(_ date: Date) {
        userDefaults.set(date, forKey: Keys.lastCurrencyUpdate)
        userDefaults.synchronize()
    }
    
    
    
}
