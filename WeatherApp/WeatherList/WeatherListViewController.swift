//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by Oussam Tlili on 07/06/2019.
//  Copyright © 2019 Oussam Tlili. All rights reserved.
//

import UIKit
import Location

class WeatherListViewController: UIViewController {
    
    // MARK: - IBoutlets
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Private attributes
    
    private let viewModel: WeatherListViewModel
    private var tableViewDelegate: WeatherListTableViewDelegate?
    private var tableViewDataSource: WeatherListTableViewDataSource?
    
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
        
        configureNavigationBar()
        
        configureTableView()
        
        bindViewModel()
        
        viewModel.loadWeatherInformations()
    }
    
    // MARK: - Private Methods
    
    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableViewDelegate = WeatherListTableViewDelegate(tableView: tableView)
        tableViewDelegate?.didSelectContentAtIndex = {[weak self] (indexPath) in
            self?.redirectToWeatherDetail()
        }
        
        tableViewDataSource = WeatherListTableViewDataSource(
            tableView: tableView,
            dataProvider: viewModel)
    }
    
    private func bindViewModel() {
        bindPageTitle()
        bindGeolocationFail()
        bindGetWeatherFail()
        bindGetWeatherSuccess()
    }
    
    private func bindPageTitle() {
        viewModel.didUpdatePageTitle = { [weak self] (pageTitle) in
            self?.updateNavigationBarTitle(pageTitle: pageTitle)
        }
    }
    
    private func bindGeolocationFail() {
        viewModel.didFailToRetreiveUserLocation = { [weak self] (error) in
            self?.displayGeolocErrorPopup(with: error)
        }
    }
    
    private func bindGetWeatherFail() {
        viewModel.didFailToRetreiveWeather = { (canLoadFromCache) in
            
        }
    }
    
    private func bindGetWeatherSuccess() {
        viewModel.didSucceedToRetreiveWeather = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureNavigationBar() {
        updateNavigationBarTitle(pageTitle: viewModel.pageTitle)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshTapped))
    }
    
    @objc private func refreshTapped(sender: UIBarButtonItem) {
        viewModel.loadWeatherInformations()
    }
    
    private func updateNavigationBarTitle(pageTitle: String) {
        title = pageTitle
    }
    
    private func redirectToWeatherDetail() {
        
    }
}

// MARK: - Geoloc extension

private extension WeatherListViewController {
    func displayGeolocErrorPopup(with error: LocationError) {
        let alert = UIAlertController(
            title: nil,
            message: error.errorMessage,
            preferredStyle: .alert)
        
        if error != .failToRetreiveLocation {
            let activateAction = UIAlertAction(
                title: NSLocalizedString("Commun.Activate", comment: ""),
                style: .default) {[weak self] _ in
                    self?.redirectToLocationActivation(error: error)
            }
            alert.addAction(activateAction)
        }
        
        let displayParisWeatherAction = UIAlertAction(
            title: NSLocalizedString("Commun.Display", comment: ""),
            style: .default) {[weak self] _ in
                self?.viewModel.loadParisWeatherInformations()
        }
        alert.addAction(displayParisWeatherAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func redirectToLocationActivation(error: LocationError) {
        if error == .notAuthorized {
            if let url = URL(string: Constants.locationPath) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if error == .serviceDisabled {
            if let url = URL(string: UIApplication.openSettingsURLString) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

// MARK : - Constants

private extension WeatherListViewController {
    enum Constants {
        static let locationPath = "App-Prefs:root=Privacy&path=LOCATION"
    }
}


