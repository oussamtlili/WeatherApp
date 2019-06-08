//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var snowLabel: UILabel!
    
    // MARK: - Public methods
    
    func configure(with weatherItem: WeatherItem) {
        dateLabel.text = weatherItem.formattedDate
        maxTemperatureLabel.text = weatherItem.maxTemperature
        minTemperatureLabel.text = weatherItem.minTemperature
        rainLabel.text = weatherItem.riskOfRain
        snowLabel.text = weatherItem.riskOfSnow
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cleanUI()
    }
    
    
    // MARK: - Private methods
    
    private func cleanUI() {
        dateLabel.text = nil
        maxTemperatureLabel.text = nil
        minTemperatureLabel.text = nil
        rainLabel.text = nil
        snowLabel.text = nil
    }
}
