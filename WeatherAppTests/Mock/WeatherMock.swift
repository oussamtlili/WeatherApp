//
//  WeatherMock.swift
//  WeatherAppTests
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

struct WeatherMock {
    
    func anyDynamicKeys(values: [String: Double] = [:]) -> DynamicKeys {
        return DynamicKeys(values: values)
    }
    
    func anyNebulosite(haute: Double = 0,
                       moyenne: Double = 0,
                       basse: Double = 0,
                       totale: Double = 0) -> Nebulosite {
        return Nebulosite(haute: haute, moyenne: moyenne, basse: basse, totale: totale)
    }
    
    func anyPressure(niveauDeLaMer: Int = 0) -> Presure {
        return Presure(niveauDeLaMer: niveauDeLaMer)
    }
    
    func anyWeather(temperature: DynamicKeys = DynamicKeys(values: [:]),
                    pression: Presure = Presure(niveauDeLaMer: 0),
                    pluie: Double = 0,
                    pluieConvective: Double = 0,
                    humidite: DynamicKeys = DynamicKeys(values: [:]),
                    ventMoyen: DynamicKeys = DynamicKeys(values: [:]),
                    ventRafales: DynamicKeys = DynamicKeys(values: [:]),
                    ventDirection: DynamicKeys = DynamicKeys(values: [:]),
                    isoZero: Double = 0,
                    risqueNeige: SnowRisk = .non,
                    cape: Double = 0,
                    nebulosite: Nebulosite = Nebulosite(haute: 0, moyenne: 0, basse: 0, totale: 0),
                    geopotentiel: Double? = nil,
                    vitesseVerticale: Double? = nil,
                    pwat: Double? = nil,
                    liftedIndex: Double? = nil,
                    mostUnstableLiftedIndex: Double? = nil,
                    mucape: Double? = nil,
                    convectiveInhibition: Double? = nil,
                    date: Date? = nil) -> Weather {
        return Weather(
            temperature: temperature,
            pression: pression,
            pluie: pluie,
            pluieConvective: pluieConvective,
            humidite: humidite,
            ventMoyen: ventMoyen,
            ventRafales: ventRafales,
            ventDirection: ventDirection,
            isoZero: isoZero,
            risqueNeige: risqueNeige,
            cape: cape,
            nebulosite: nebulosite,
            geopotentiel: geopotentiel,
            vitesseVerticale: vitesseVerticale,
            pwat: pwat,
            liftedIndex: liftedIndex,
            mostUnstableLiftedIndex: mostUnstableLiftedIndex,
            mucape: mucape,
            convectiveInhibition: convectiveInhibition,
            date: date)
    }
}

