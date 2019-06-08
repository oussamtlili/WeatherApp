//
//  WeatherListTableViewDelegate.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewDelegate : NSObject {
    
    // MARK: - Public attributes
    
    var didSelectContentAtIndex: ((IndexPath) -> Void)?
    
    // MARK: - Private attributes
    
    private weak var tableView: UITableView?
    
    // MARK: - Init
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
    }
}

// MARK : UITableViewDelegate
extension WeatherListTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectContentAtIndex?(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
