//
//  LocationError.swift
//  Location
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

public enum LocationError: Error {
    case serviceDisabled
    case notAuthorized
    case failToRetreiveLocation
}

