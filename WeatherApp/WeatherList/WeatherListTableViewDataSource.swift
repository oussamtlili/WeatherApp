//
//  WeatherListTableViewDataSource.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import ClientApi

protocol WeatherListTableViewDataProvider: AnyObject {
    func getData() -> [WeatherItem]?
}

class WeatherListTableViewDataSource: NSObject {
    
    // MARK: - Private attributes
    
    private weak var tableView: UITableView?
    private weak var dataProvider: WeatherListTableViewDataProvider?
    
    // MARK: - Init
    
    init(tableView: UITableView, dataProvider: WeatherListTableViewDataProvider) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        super.init()
        tableView.dataSource = self
        registerCells()
    }
    
    // MARK: - Private methods
    
    private func registerCells() {
        tableView?.register(
            UINib(nibName: "WeatherTableViewCell", bundle: nil),
            forCellReuseIdentifier: Constants.weatherCellIdentifier)
    }
}

// MARK : - UITableViewDataSource

extension WeatherListTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataProvider?.getData() else {
            return 0
        }
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.weatherCellIdentifier, for: indexPath) as? WeatherTableViewCell,
            let weatherItem = dataProvider?.getData()?[indexPath.row] else {
                return UITableViewCell()
        }


        cell.configure(with: weatherItem)

        return cell
    }
}

// MARK : - Constants

private extension WeatherListTableViewDataSource {
    enum Constants {
        static let weatherCellIdentifier = "WeatherTableViewCell"
    }
}
