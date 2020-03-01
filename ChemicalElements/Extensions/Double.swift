//
//  Double.swift
//  ChemicalElements
//
//  Created by John on 1/20/20.
//  Copyright © 2020 Abraham Shenghur. All rights reserved.
//

import Foundation

extension Double {
    
    func truncate(to places: Int) -> Double {
        let newDecimal = pow(10, Double(places)) * self
        let truncated = Double(Int(newDecimal))
        let originalDecimal = truncated / pow(10, Double(places))
        return originalDecimal
    }
}
