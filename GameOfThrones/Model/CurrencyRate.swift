//
//  CurrencyRate.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct CurrencyRate: Decodable {
    let currency: String
    let exchangeRate: Double
}
