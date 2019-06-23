//
//  FetchedCurrency.swift
//  
//
//  Created by Ivan Ruiz Monjo on 19/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct SavedCurrency: Codable {
    let from: Currency
    let to: Currency
    let date: Date
    let exchangeRate: Double
}

extension SavedCurrency: Equatable, Hashable {
    static func == (lhs: SavedCurrency, rhs: SavedCurrency) -> Bool {
        return lhs.from == rhs.from && lhs.to == rhs.to
    }
}
