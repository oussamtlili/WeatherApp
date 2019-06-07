//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {
    // MARK: - Private attributes
    
    private let viewModel: WeatherListViewModel
    
    // MARK: - Init
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
