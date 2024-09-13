//
//  CityListViewController.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

final class CitiesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var citiesWeather: [String: Double] = [:]
    private let presenter: CitiesListPresenterInput
    private let tableView = UITableView()
    
    init(presenter: CitiesListPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.loadCitiesWeather()
    }
    
    private func setupUI() {
        title = "Cities Weather"
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let city = Array(citiesWeather.keys)[indexPath.row]
        let temperature = citiesWeather[city] ?? 0
        cell.textLabel?.text = city
        cell.detailTextLabel?.text = "\(temperature)°C"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = Array(citiesWeather.keys)[indexPath.row]
        let cityDetailVC = CityDetailRouter.createModule(for: city, days: 7)
        navigationController?.pushViewController(cityDetailVC, animated: true)
    }
}

//MARK: - Extension
extension CitiesListViewController: CitiesListPresenterOutput {
    func showCitiesWeather(_ citiesWeather: [String: Double]) {
        self.citiesWeather = citiesWeather
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print("Error fetching cities weather: \(error.localizedDescription)")
    }
}
