//
//  NetworkProvider.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

protocol NetworkProviderProtocol {
    func request(_ endpoint: EndpointProtocol,
                 completionBlock: @escaping ((_ data: Data) -> ()),
                 errorBlock: @escaping ((_ error: GotError) -> ()))
}
