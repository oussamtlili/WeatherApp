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
            guard let `self` = self else { return }
            
            if let weatherItem = self.viewModel.getData()?[indexPath.row] {
                self.redirectToWeatherDetail(weatherItem: weatherItem)
            }
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
        viewModel.didFailToRetreiveWeather = {[weak self] (canLoadFromCache) in
            guard let `self` = self else { return }
            if canLoadFromCache {
                self.displayRetreiveWeatherErrorWithCache()
            } else {
                self.displayRetreiveWeatherErrorWithoutCache()
            }
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
    
    private func redirectToWeatherDetail(weatherItem: WeatherItem) {
        let weatherDetailViewModel = WeatherDetailViewModel(weathersItem: weatherItem)
        let weatherDetailViewController = WeatherDetailViewController(
            viewModel: weatherDetailViewModel)
        
        navigationController?.pushViewController(weatherDetailViewController, animated: true)
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


// MARK: - Weather retreive faillure extension

private extension WeatherListViewController {
    
    func displayRetreiveWeatherErrorWithoutCache() {
        let alert = UIAlertController(
                    title: nil,
                    message: NSLocalizedString("Commun.FailToRetreiveWeatherWithoutCache", comment: ""),
                    preferredStyle: .alert)
        let action = UIAlertAction(
            title: NSLocalizedString("Commun.Ok", comment: ""),
            style: .default,
            handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func displayRetreiveWeatherErrorWithCache() {
        let alert = UIAlertController(
            title: nil,
            message: NSLocalizedString("Commun.FailToRetreiveWeatherWithCache", comment: ""),
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: NSLocalizedString("Commun.Ok", comment: ""),
            style: .default) { [weak self] _ in
                self?.viewModel.retreiveFromCache()
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}



// MARK : - Constants

private extension WeatherListViewController {
    enum Constants {
        static let locationPath = "App-Prefs:root=Privacy&path=LOCATION"
    }
}


