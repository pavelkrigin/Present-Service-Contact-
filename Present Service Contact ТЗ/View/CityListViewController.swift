//
//  CityListViewController.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

protocol CityListViewProtocol: AnyObject {
    func showCities(_ cities: [City])
}

class CityListViewController: UIViewController, CityListViewProtocol {
    var presenter: CityListPresenterProtocol?
    var cities: [City] = []
    
    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cities"
        view.backgroundColor = .white
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        addButton.setTitle("Add City", for: .normal)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        addButton.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        tableView.tableHeaderView = addButton
    }
    
    @objc private func didTapAddButton() {
        presenter?.showCitySearch()
    }
    
    func showCities(_ cities: [City]) {
        self.cities = cities
        tableView.reloadData()
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CityCell")
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = "\(city.temperature)°C"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        presenter?.showCityDetail(for: city.name)
    }
}
