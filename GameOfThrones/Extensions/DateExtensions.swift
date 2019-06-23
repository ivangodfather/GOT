//
//  DateExtensions.swift
//  
//
//  Created by Ivan Ruiz Monjo on 19/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension Date {
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    func isDateInToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
}
