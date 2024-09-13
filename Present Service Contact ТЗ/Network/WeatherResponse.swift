//
//  WeatherResponse.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 13.09.2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    struct Main: Decodable {
        let temp: Double
    }
    
    struct Weather: Decodable {
        let description: String
    }
}
