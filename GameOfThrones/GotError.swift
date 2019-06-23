//
//  GotError.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

enum GotError: Swift.Error {
    case invalidJSON
    case connectionError
    case invalidURL
    case missingFields
    case unkown
    
    var localizedDescription: String {
        switch self {
        case .missingFields: return "All fields are required."
        default: return "Internal error."
        }
    }
}
