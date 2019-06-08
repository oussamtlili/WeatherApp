//
//  Weather.swift
//  ClientApi
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation


public struct Weather: Codable {
    
    public let temperature: DynamicKeys
    
    public let pression: Presure
    
    public let pluie: Double
    
    public let pluieConvective: Double
    
    public let humidite: DynamicKeys
    
    public let ventMoyen: DynamicKeys
    
    public let ventRafales: DynamicKeys
    
    public let ventDirection: DynamicKeys
    
    public let isoZero: Double
    
    public let risqueNeige: SnowRisk
    
    public let cape: Double
    
    public let nebulosite: Nebulosite
    
    public let geopotentiel: Double?
    
    public let vitesseVerticale: Double?
    
    public let pwat: Double?
    
    public let liftedIndex: Double?
    
    public let mostUnstableLiftedIndex: Double?
    
    public let mucape: Double?
    
    public let convectiveInhibition: Double?
    
    public var date: Date?
    
    private enum CodingKeys: String, CodingKey {
        case temperature
        case pression
        case pluie
        case pluieConvective = "pluie_convective"
        case humidite
        case ventMoyen = "vent_moyen"
        case ventRafales = "vent_rafales"
        case ventDirection = "vent_direction"
        case isoZero = "iso_zero"
        case risqueNeige = "risque_neige"
        case cape
        case nebulosite
        case geopotentiel
        case vitesseVerticale = "vitesse_verticale"
        case pwat
        case liftedIndex = "liftedIndex"
        case mostUnstableLiftedIndex = "most_unstable_lifted_index"
        case mucape
        case convectiveInhibition = "convective_inhibition"
        case date = "date"
    }
}
