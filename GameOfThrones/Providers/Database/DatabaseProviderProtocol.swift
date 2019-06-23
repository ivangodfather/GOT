//
//  DatabaseProvider.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

protocol DatabaseProviderProtocol {
    func saveWarrior(_ warrior: Warrior)
    func currentWarrior() -> Warrior?
    func savedCurrencies() -> Set<SavedCurrency>
    func saveCurrencies(_ currencies: Set<SavedCurrency>)
    func lastCurrencyUpdate() -> Date?
    func updateCurrencyDate(_ date: Date)
}
