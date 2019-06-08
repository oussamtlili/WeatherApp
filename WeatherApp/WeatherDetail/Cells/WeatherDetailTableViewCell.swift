//
//  WeatherDetailTableViewCell.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var riskOfRainLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var riskOfSnowLabel: UILabel!
    
    // MARK: - Public methods
    
    func configure(with weatherDetailItem: WeatherDetailItem) {
        hourLabel.text = weatherDetailItem.time
        riskOfRainLabel.text = weatherDetailItem.riskOfRain
        temperatureLabel.text = weatherDetailItem.temperature
        riskOfSnowLabel.text = weatherDetailItem.riskOfSnow
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cleanUI()
    }
    
    
    // MARK: - Private methods
    
    private func cleanUI() {
        hourLabel.text = nil
        riskOfRainLabel.text = nil
        temperatureLabel.text = nil
        riskOfSnowLabel.text = nil
    }
}
