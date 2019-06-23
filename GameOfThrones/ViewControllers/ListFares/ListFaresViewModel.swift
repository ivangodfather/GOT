//
//  ListFaresViewModel.swift
//  
//
//  Created by Ivan Ruiz Monjo on 20/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

final class ListFaresViewModel {
    
    private let flights: [Flight]
    
    init(flights: [Flight]) {
        self.flights = flights
    }
    
    // Input
    func viewDidLoad() {
        updateState?(State.loaded(flights))
    }
    
    // Output
    var updateState: ((State) -> ())?
}

extension ListFaresViewModel {
    enum State {
        case loaded([Flight])
    }
}
