//
//  WeatherForecastResponse.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 13.09.2024.
//

import Foundation

struct WeatherForecastResponse: Decodable {
    let city: City
    let list: [ForecastDay]
    
    struct City: Decodable {
        let name: String
    }
    
    struct ForecastDay: Decodable {
        let dt: Int
        let temp: Temp
        let weather: [Weather]
        
        struct Temp: Decodable {
            let day: Double
        }
        
        struct Weather: Decodable {
            let description: String
        }
    }
}
