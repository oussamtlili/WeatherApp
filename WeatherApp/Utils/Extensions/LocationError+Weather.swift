//
//  LocationError+Weather.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import Location

extension LocationError {
    var errorMessage: String {
        switch self {
        case .notAuthorized:
            return NSLocalizedString("Commun.LocationError.NotAuthorized", comment: "")
        case .serviceDisabled:
            return NSLocalizedString("Commun.LocationError.ServiceDisabled", comment: "")
        case .failToRetreiveLocation:
            return NSLocalizedString("Commun.LocationError.FailToRetreiveLocation", comment: "")
        }
    }
}
