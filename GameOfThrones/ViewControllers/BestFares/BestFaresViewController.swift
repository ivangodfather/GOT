//
//  BestFaresViewController.swift
//  
//
//  Created by Ivan Ruiz Monjo on 19/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

final class BestFaresViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let viewModel = BestFaresViewModel()
    private var bestFares: [Flight] = [] {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initVM()
    }
    
    private func initVM() {
        viewModel.updateState = { [weak self] state in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                switch state {
                case .loading:
                    strongSelf.activityIndicatorView.startAnimating()
                case .loaded(let bestFares):
                    strongSelf.activityIndicatorView.stopAnimating()
                    strongSelf.bestFares = bestFares
                case .navigatelistFares(let flights):
                    strongSelf.coordinator?.showListFares(flights: flights)
                case .error(let error):
                    strongSelf.showError(error)
                }
            }
        }
        viewModel.viewDidLoad()
    }
    
    private func setupTableView() {
        let nibName = String(describing: BestFaresTableViewCell.self)
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
}

extension BestFaresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BestFaresTableViewCell.self), for: indexPath) as! BestFaresTableViewCell
        let flight = bestFares[indexPath.row]
        cell.setup(flight)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestFares.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flight = bestFares[indexPath.row]
        viewModel.userSelected(flight)
    }
}
