//
//  Endpoints.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

enum Endpoints: EndpointProtocol {
    case flights
    case currencyConverter(from: String, to: String)
    
    var url: String {
        switch self {
        case .flights: return "http://odigeo-testios.herokuapp.com"
        case let .currencyConverter(from, to): return "http://jarvisstark.herokuapp.com/currency?from=\(from)&to=\(to)"
        }
    }
    
    var method: String {
        return "GET"
    }
}
