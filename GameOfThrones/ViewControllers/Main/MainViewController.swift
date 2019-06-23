//
//  ViewController.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

final class MainViewController: BaseViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showAvailableDestinations(_ sender: Any) {
        coordinator?.showAvailableDestinations()
    }
    
    @IBAction func showSettings(_ sender: Any) {
        coordinator?.showSettings()
    }
}

