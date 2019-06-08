//
//  WeatherDetailTableViewDataSource.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherDetailTableViewDataProvider: AnyObject {
    func getData() -> [WeatherDetailItem]
}

class WeatherDetailTableViewDataSource: NSObject {
    
    // MARK: - Private attributes
    
    private weak var tableView: UITableView?
    private weak var dataProvider: WeatherDetailTableViewDataProvider?
    
    // MARK: - Init
    
    init(tableView: UITableView, dataProvider: WeatherDetailTableViewDataProvider) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        super.init()
        tableView.dataSource = self
        registerCells()
    }
    
    // MARK: - Private methods
    
    private func registerCells() {
        tableView?.register(
            UINib(nibName: "WeatherDetailTableViewCell", bundle: nil),
            forCellReuseIdentifier: Constants.weatherDetailCellIdentifier)
    }
}

// MARK : - UITableViewDataSource

extension WeatherDetailTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataProvider?.getData() else {
            return 0
        }
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.weatherDetailCellIdentifier, for: indexPath) as? WeatherDetailTableViewCell,
            let weatherDetailItem = dataProvider?.getData()[indexPath.row]
            else { return UITableViewCell() }
        
        
        cell.configure(with: weatherDetailItem)
        
        return cell
    }
}

// MARK : - Constants

private extension WeatherDetailTableViewDataSource {
    enum Constants {
        static let weatherDetailCellIdentifier = "WeatherDetailTableViewCell"
    }
}

