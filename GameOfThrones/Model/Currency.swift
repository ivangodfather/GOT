//
//  Currency.swift
//  
//
//  Created by Ivan Ruiz Monjo on 20/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

enum Currency: String, CaseIterable, Codable {
    case eur = "EUR"
    case usd = "USD"
    case gbp = "GBP"
    case jpy = "JPY"
}
