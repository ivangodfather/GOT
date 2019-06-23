//
//  Flight.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Flight: Decodable {
    let inbound: Segment
    let outbound: Segment
    let price: Double
    let currency: Currency
    
    init(flight: Flight, updatedPrice: Double, with newCurrency: Currency) {
        inbound = flight.inbound
        outbound = flight.outbound
        price = updatedPrice
        currency = newCurrency
    }
}
