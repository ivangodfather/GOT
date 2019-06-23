//
//  SettingsViewModel.swift
//  
//
//  Created by Ivan Ruiz Monjo on 19/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

final class SettingsViewModel {
    
    private let warriorService: WarriorServiceProtocol
    private let currencyService: CurrencyServiceProtocol
    
    init(warriorService: WarriorServiceProtocol = WarriorService(),
         currencyService: CurrencyServiceProtocol = CurrencyService()) {
        self.warriorService = warriorService
        self.currencyService = currencyService
    }
    
    // Input
    func viewDidLoad() {
        let currentWarrior = warriorService.currentWarrior()
        let availableCurrencies = currencyService.availableCurrencies()
        updateState?(State.loaded(currentWarrior, availableCurrencies))
    }
    
    func saveWarrior(name: String, surname: String, birthdate: Date, currency: String) {
        guard name.count > 0, surname.count > 0, currency.count > 0, let currency = Currency(rawValue: currency) else {
            updateState?(State.error(.missingFields))
            return
        }
        let warrior = Warrior(name: name, surname: surname, currency: currency, birthdate: birthdate)
        warriorService.saveWarrior(warrior)
        updateState?(State.saved(warrior))
    }
    
    // Output
    var updateState: ((State) -> ())?
}

extension SettingsViewModel {
    enum State {
        case loaded(Warrior?, [Currency])
        case error(GotError)
        case saved(Warrior)
    }
}

