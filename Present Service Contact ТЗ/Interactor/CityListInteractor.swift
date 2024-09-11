//
//  CityListInteractor.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

protocol CityListInteractorProtocol: AnyObject {
    func fetchCities()
}

protocol CityListInteractorOutputProtocol: AnyObject {
    func didFetchCities(_ cities: [City])
}

class CityListInteractor: CityListInteractorProtocol {
    weak var presenter: CityListInteractorOutputProtocol?
    let weatherService = WeatherService()
    
    func fetchCities() {
        var cities: [City] = []
        if let savedCities = loadSavedCities() {
            cities = savedCities
        } else {
            
            cities = [City(name: "Moscow", temperature: 0), City(name: "London", temperature: 0)]
        }
        
        var cityObjects: [City] = []
        let dispatchGroup = DispatchGroup()
        
        for city in cities {
            dispatchGroup.enter()
            weatherService.fetchWeatherForecast(for: city.name) { result in
                switch result {
                case .success(let data):
                    let cityObject = City(name: data.name, temperature: data.main.temp)
                    cityObjects.append(cityObject)
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.presenter?.didFetchCities(cityObjects)
        }
    }
    
    func loadSavedCities() -> [City]? {
        if let data = UserDefaults.standard.data(forKey: "savedCities") {
            let decoder = JSONDecoder()
            return try? decoder.decode([City].self, from: data)
        }
        return nil
    }
}
