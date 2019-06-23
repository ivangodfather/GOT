//
//  AppCoordinator.swift
//  
//
//  Created by Ivan Ruiz Monjo on 18/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class AppCoordinator: CoordinatorProtocol {
    var childCoordinators = [CoordinatorProtocol]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController(nibName: String(describing: MainViewController.self), bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showSettings() {
        let vc = SettingsViewController(nibName: String(describing: SettingsViewController.self), bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAvailableDestinations() {
        let vc = BestFaresViewController(nibName: String(describing: BestFaresViewController.self), bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showListFares(flights: [Flight]) {
        let viewModel =  ListFaresViewModel(flights: flights)
        let vc = ListFaresViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
