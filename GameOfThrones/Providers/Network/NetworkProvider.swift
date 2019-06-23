//
//  NetworkProvider.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation



final class NetworkProvider: NetworkProviderProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    

    
    func request(_ endpoint: EndpointProtocol,
                 completionBlock: @escaping ((_ data: Data) -> ()),
                 errorBlock: @escaping ((_ error: GotError) -> ())) {
        guard let url = URL(string: endpoint.url) else {
            errorBlock(GotError.invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data,
                error == nil else {
                errorBlock(GotError.connectionError)
                return
            }
            completionBlock(data)
        }
        task.resume()
    }
}
