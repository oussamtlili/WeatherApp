//
//  Weather.swift
//  ClientApi
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation


public struct Weather: Codable {
    
    let temperature: DynamicKeys
    
    let pression: Presure
    
    let pluie: Double
    
    let pluieConvective: Double
    
    let humidite: DynamicKeys
    
    let ventMoyen: DynamicKeys
    
    let ventRafales: DynamicKeys
    
    let ventDirection: DynamicKeys
    
    let isoZero: Double
    
    let risqueNeige: SnowRisk
    
    let cape: Double
    
    let nebulosite: Nebulosite
    
    let geopotentiel: Double?
    
    let vitesseVerticale: Double?
    
    let pwat: Double?
    
    let liftedIndex: Double?
    
    let mostUnstableLiftedIndex: Double?
    
    let mucape: Double?
    
    let convectiveInhibition: Double?
    
    var date: Date = Date()
    
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
    }
}
