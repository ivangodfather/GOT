//
//  UIViewControllerExtensions.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ error: GotError) {
        showMessage(error.localizedDescription)
    }
    
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
