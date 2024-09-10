//
//  CityDetailViewController.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

protocol CityDetailViewProtocol: AnyObject {
    func showWeatherDetails(_ details: WeatherData)
}

class CityDetailViewController: UIViewController {
    var presenter: CityDetailPresenterProtocol?
    
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let humidityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(humidityLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension CityDetailViewController: CityDetailViewProtocol {
    func showWeatherDetails(_ details: WeatherData) {
        cityLabel.text = details.name
        temperatureLabel.text = "Temperature: \(details.main.temp)°C"
        humidityLabel.text = "Humidity: \(details.main.humidity)%"
    }
}

