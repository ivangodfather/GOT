//
//  FlightFaresTableViewCell.swift
//  
//
//  Created by Ivan Ruiz Monjo on 20/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

final class FlightFaresTableViewCell: UITableViewCell {

    @IBOutlet private weak var rideDetailsLabel: UILabel!
    @IBOutlet private weak var inboundSegmentLabel: UILabel!
    @IBOutlet private weak var inboundDateLabel: UILabel!
    @IBOutlet private weak var inboundTimeLabel: UILabel!
    @IBOutlet private weak var outboundSegmentLabel: UILabel!
    @IBOutlet private weak var outboundDateLabel: UILabel!
    @IBOutlet private weak var outboundTimeLabel: UILabel!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(flight: Flight) {
        rideDetailsLabel.text = "\(flight.inbound.origin) - \(flight.inbound.destination)"
        inboundSegmentLabel.text = "Departure"
        inboundDateLabel.text = flight.inbound.departureDate
        inboundTimeLabel.text = flight.inbound.departureTime
        outboundSegmentLabel.text = "Return"
        outboundDateLabel.text = flight.outbound.departureDate
        outboundTimeLabel.text = flight.outbound.departureTime
        priceLabel.text = flight.price.description
        currencyLabel.text = flight.currency.rawValue

    }
    
}
