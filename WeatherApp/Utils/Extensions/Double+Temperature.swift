//
//  Double+Temperature.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

extension Double {
    
    var celsiusFromKelvin: Double {
        return self - Constatns.kelvinCellsusDiff
    }
    
    var formattedTemperature: String {
        return "\(Int(self))°c"
    }
}

private extension Double {
    enum Constatns {
        static let kelvinCellsusDiff: Double = 273.15
    }
}
