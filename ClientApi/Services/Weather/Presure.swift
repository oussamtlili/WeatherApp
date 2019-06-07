//
//  Pression.swift
//  ClientApi
//
//  Created by Oussam Tlili on 06/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation

public struct Presure: Codable {
    public let niveauDeLaMer: Int
    
    private enum CodingKeys: String, CodingKey {
        case niveauDeLaMer = "niveau_de_la_mer"
    }
}
