//
//  ListFaresViewController.swift
//  
//
//  Created by Ivan Ruiz Monjo on 20/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

final class ListFaresViewController: UIViewController {

    private let viewModel: ListFaresViewModel
    @IBOutlet private weak var tableView: UITableView!
    private var flights: [Flight] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initVM()
    }
    
    private func initVM() {
        viewModel.updateState = { state in
            switch state {
            case .loaded(let flights):
                self.flights = flights
            }
        }
        viewModel.viewDidLoad()
    }
    
    private func setupTableView() {
        let nibName = String(describing: FlightFaresTableViewCell.self)
        tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    init(viewModel: ListFaresViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ListFaresViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ListFaresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FlightFaresTableViewCell.self), for: indexPath) as! FlightFaresTableViewCell
        let flight = flights[indexPath.row]
        cell.setup(flight: flight)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
}
