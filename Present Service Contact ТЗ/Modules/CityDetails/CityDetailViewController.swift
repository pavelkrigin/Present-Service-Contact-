//
//  CityDetailViewController.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

final class CityDetailViewController: UIViewController, UITableViewDataSource {
    private var weatherDetails: [WeatherDetail] = []
    private let presenter: CityDetailPresenterInput
    private let tableView = UITableView()

    init(presenter: CityDetailPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.loadWeatherDetail()
    }

    private func setupUI() {
        title = "Weather Details"
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let detail = weatherDetails[indexPath.row]
        cell.textLabel?.text = detail.date
        cell.detailTextLabel?.text = "\(detail.temperature)°C - \(detail.description)"
        return cell
    }
}

extension CityDetailViewController: CityDetailPresenterOutput {
    func showWeatherDetail(_ weatherDetails: [WeatherDetail]) {
        self.weatherDetails = weatherDetails
        tableView.reloadData()
    }

    func showError(_ error: Error) {
        print("Error fetching weather details: \(error.localizedDescription)")
    }
}
