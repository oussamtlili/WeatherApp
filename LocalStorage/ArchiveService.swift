//
//  ArchiveService.swift
//  LocalStorage
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

public protocol ArchiveService {
    func store(weathers: [Weather]?)
    func store(cityName: String?)
    func retriveWeathers() -> [Weather]?
    func retriveCityName() -> String?
}
