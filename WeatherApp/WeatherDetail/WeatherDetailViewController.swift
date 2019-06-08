//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 08/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private attributes
    
    private let viewModel: WeatherDetailViewModel
    private var tableViewDataSource: WeatherDetailTableViewDataSource?
    
    //MARK: - Init
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.pageTitle
        
        configureTableView()
    }
    
    //MARK: - Private methods
    
    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableViewDataSource = WeatherDetailTableViewDataSource(tableView: tableView, dataProvider: viewModel)
        tableView.reloadData()
    }
}
