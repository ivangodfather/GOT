//
//  CurrencyService.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

protocol CurrencyServiceProtocol {
    func availableCurrencies() -> [Currency]
    func savedCurrencies(result: @escaping (CurrencyServiceResult) -> ())
    func defaultCurrency() -> Currency
}

enum CurrencyServiceResult {
    case succeed(Set<SavedCurrency>)
    case error(GotError)
}

final class CurrencyService: CurrencyServiceProtocol {
    
    private let networkProvider: NetworkProviderProtocol
    private let databaseProvider: DatabaseProviderProtocol

    init(networkProvider: NetworkProviderProtocol = NetworkProvider(),
         databaseProvider: DatabaseProviderProtocol = DatabaseProvider()) {
        self.networkProvider = networkProvider
        self.databaseProvider = databaseProvider
    }
    
    func defaultCurrency() -> Currency {
        return Currency.eur
    }
    
    func availableCurrencies() -> [Currency] {
        return Currency.allCases
    }
    
    func savedCurrencies(result: @escaping (CurrencyServiceResult) -> ()) {
        if canRetrieveValuesForToday() {
            result(CurrencyServiceResult.succeed(databaseProvider.savedCurrencies()))
        } else {
            updateCurrencies { [weak self] in
                guard let strongSelf = self else {
                    result(CurrencyServiceResult.error(GotError.unkown))
                    return
                }
                strongSelf.savedCurrencies(result: result)
            }
        }
    }
    
    private func canRetrieveValuesForToday() -> Bool {
        guard let lastCurrencyUpdate = databaseProvider.lastCurrencyUpdate() else {
            return false
        }
        return lastCurrencyUpdate.isDateInToday()
    }
    
    private func updateCurrencies(completionBlock: @escaping () -> ()) {
        var savedCurrencies = Set<SavedCurrency>()
        let currencyCombinations = availableCurrencies()
            .allCombinations()
        
        let dispatchGroup = DispatchGroup()
        
        currencyCombinations.forEach { (from, to) in
            dispatchGroup.enter()
            networkProvider.request(Endpoints.currencyConverter(from: from.rawValue, to: to.rawValue), completionBlock: { data in
                let jsonDecoder = JSONDecoder()
                guard let currency = try? jsonDecoder.decode(CurrencyRate.self, from: data) else {
                    dispatchGroup.leave()
                    return
                }
                let savedCurrency = SavedCurrency(from: from, to: to, date: Date(), exchangeRate: currency.exchangeRate)
                savedCurrencies.update(with: savedCurrency)
                dispatchGroup.leave()
            }, errorBlock: { error in
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.databaseProvider.saveCurrencies(savedCurrencies)
            self?.databaseProvider.updateCurrencyDate(Date())
            completionBlock()
        }
    }

}

