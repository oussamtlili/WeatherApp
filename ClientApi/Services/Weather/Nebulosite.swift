//
//  Nebulosite.swift
//  MyWeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

public struct Nebulosite: Codable {
    public let haute: Double
    public let moyenne: Double
    public let basse: Double
    public let totale: Double
    
    public init(haute: Double,
                moyenne: Double,
                basse: Double,
                totale: Double) {
        self.haute = haute
        self.moyenne = moyenne
        self.basse = basse
        self.totale = totale
    }
}
