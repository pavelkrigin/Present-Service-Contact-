//
//  CityDetailViewController.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import UIKit

protocol CityDetailViewProtocol: AnyObject {
    func showWeatherDetails(_ weather: WeatherData)
}

class CityDetailViewController: UIViewController, CityDetailViewProtocol {
    var presenter: CityDetailPresenterProtocol?
    
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let humidityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Details"
        view.backgroundColor = .white
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        temperatureLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 50)
        temperatureLabel.textAlignment = .center
        view.addSubview(temperatureLabel)
        
        descriptionLabel.frame = CGRect(x: 20, y: 160, width: view.bounds.width - 40, height: 50)
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        humidityLabel.frame = CGRect(x: 20, y: 220, width: view.bounds.width - 40, height: 50)
        humidityLabel.textAlignment = .center
        view.addSubview(humidityLabel)
    }
    
    func showWeatherDetails(_ weather: WeatherData) {
        temperatureLabel.text = "Temperature: \(weather.main.temp)°C"
        descriptionLabel.text = "Description: \(weather.weather.first?.description ?? "No data")"
        humidityLabel.text = "Humidity: \(weather.main.humidity)%"
    }
    
    
}
