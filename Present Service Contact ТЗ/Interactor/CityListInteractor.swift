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

class CityListInteractor: CityListInteractorProtocol {
    var presenter: CityListPresenterProtocol?
    let weatherService = WeatherService()
    
    func fetchCities() {
        // Пример городов
        let cities = ["Moscow", "London"]
        var cityObjects: [City] = []
        
        let dispatchGroup = DispatchGroup()
        
        for city in cities {
            dispatchGroup.enter()
            weatherService.fetchWeather(for: city) { result in
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
}


