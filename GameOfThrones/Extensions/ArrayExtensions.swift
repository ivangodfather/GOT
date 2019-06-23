//
//  ArrayExtensions.swift
//  
//
//  Created by Ivan Ruiz Monjo on 20/10/2018.
//  Copyright © 2018 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element: Equatable
{
    func allCombinations() -> [(Element, Element)] {
        var combinations = [(Element, Element)]()
        self.forEach { value in
            self.forEach{ otherValue in
                if value != otherValue {
                    combinations.append((value, otherValue))
                }
            }
        }
        return combinations
    }
}
