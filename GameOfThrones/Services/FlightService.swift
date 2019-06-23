//
//  FlightService.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

protocol FlightServiceProtocol {
    func availableFlights(result: @escaping (FlightServiceResult) -> ())
    func bestFaresGroupedByDestination(_ flights: [Flight]) -> [Flight]
    func flights(origin: String, destination: String, from flights: [Flight]) -> [Flight]
}

enum FlightServiceResult {
    case succeed(flights: [Flight])
    case error(GotError)
}

final class FlightService: FlightServiceProtocol {
    
    private let networkProvider: NetworkProviderProtocol
    
    init(networkProvider: NetworkProviderProtocol = NetworkProvider()) {
        self.networkProvider = networkProvider
    }
    
    func availableFlights(result: @escaping (FlightServiceResult) -> ()) {
        networkProvider.request(Endpoints.flights, completionBlock: { data in
            let jsonDecoder = JSONDecoder()
            guard let flightsResponse = try? jsonDecoder.decode(FlightsResponse.self, from: data) else {
                result(FlightServiceResult.error(.invalidJSON))
                return
            }
            result(FlightServiceResult.succeed(flights: flightsResponse.results))
        }) { error in
            result(FlightServiceResult.error(error))
        }
    }
    
    func bestFaresGroupedByDestination(_ flights: [Flight]) -> [Flight] {
        let groupedFlights = Dictionary(grouping: flights, by: { $0.inbound.origin + "," + $0.inbound.destination })
        var bestFares: [Flight] = []
        groupedFlights.forEach { dic in
            let bestFare = dic.1.sorted { $0.price < $1.price }.first
            if let bestFare = bestFare {
                bestFares.append(bestFare)
            }
        }
        return bestFares
    }
    
    func flights(origin: String, destination: String, from flights: [Flight]) -> [Flight] {
        let groupedFlights = Dictionary(grouping: flights, by: { $0.inbound.origin + "," + $0.inbound.destination })
        let key = origin + "," + destination
        if let flights = groupedFlights[key] {
            return flights
        }
        return []
    }
}
