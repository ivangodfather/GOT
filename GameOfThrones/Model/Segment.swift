//
//  Segment.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

struct Segment: Decodable {
    let airline: String
    let airlineImage: String
    let arrivalDate: String
    let arrivalTime: String
    let departureDate: String
    let departureTime: String
    let destination: String
    let origin: String
}
