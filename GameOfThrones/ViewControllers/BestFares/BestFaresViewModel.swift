//
//  BestFaresViewModel.swift
//  
//
//  Created by Ivan Ruiz Monjo on 19/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

final class BestFaresViewModel {
    
    private let flightService: FlightServiceProtocol
    private let currencyService: CurrencyServiceProtocol
    private let warriorService: WarriorServiceProtocol
    private var availableFlights = [Flight]()
    
    init(flightService: FlightServiceProtocol = FlightService(),
         currencyService: CurrencyServiceProtocol = CurrencyService(),
         warriorService: WarriorServiceProtocol = WarriorService()) {
        self.flightService = flightService
        self.currencyService = currencyService
        self.warriorService = warriorService
    }
    
    // Input
    func viewDidLoad() {
        flightService.availableFlights { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .succeed(let availableFlights):
                self?.availableFlights = availableFlights
                let bestFares = strongSelf.flightService.bestFaresGroupedByDestination(availableFlights)
                let currency = strongSelf.warriorService.currentWarrior()?.currency ?? strongSelf.currencyService.defaultCurrency()
                strongSelf.updateFlightsPrices(with: currency, flights: bestFares, updatedFlights: { flights in
                    let sorted = flights.sorted(by: { $0.price < $1.price })
                    strongSelf.updateState?(State.loaded(sorted))
                }) { error in
                    strongSelf.updateState?(State.error(error))
                }
                break
            case .error(let error):
                strongSelf.updateState?(State.error(error))
            }
        }
    }
    
    func userSelected(_ flight: Flight) {
        let flights = flightService.flights(origin: flight.inbound.origin, destination: flight.inbound.destination, from: availableFlights)
        updateState?(State.navigatelistFares(flights))
    }
    
    // Output
    var updateState: ((State) -> ())?
    
    private func updateFlightsPrices(with currency:  Currency,
                                                     flights: [Flight],
                                                     updatedFlights: @escaping (([Flight]) -> ()),
                                                     errorOcurred: @escaping (GotError) -> ()) {
        currencyService.savedCurrencies { result in
            switch result {
            case .succeed(let savedCurrencies):
                let flights = flights.compactMap { flight -> Flight? in
                    let filteredCurrency = savedCurrencies.filter { $0.to == currency && $0.from == flight.currency }.first
                    if let filteredCurrency = filteredCurrency {
                        return Flight(flight: flight, updatedPrice: filteredCurrency.exchangeRate * flight.price, with: currency)
                    }
                    return nil // Maybe we also want to return this flights without updating currency?
                }
                updatedFlights(flights)
            case .error(let error):
                errorOcurred(error)
            }
        }
    }
}

extension BestFaresViewModel {
    enum State {
        case loading
        case loaded([Flight])
        case error(GotError)
        case navigatelistFares([Flight])
    }
}
