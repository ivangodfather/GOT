//
//  BestFaresTableViewCell.swift
//  
//
//  Created by Ivan Ruiz Monjo on 19/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

final class BestFaresTableViewCell: UITableViewCell {

    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var fareLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ flight: Flight) {
        infoLabel.text = "\(flight.inbound.origin) - \(flight.inbound.destination)"
        fareLabel.text = "from" + " \(flight.currency) " + String(format: "%.2f", flight.price) 
    }
    
}
