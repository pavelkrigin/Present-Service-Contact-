//
//  WeatherData.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

struct WeatherData: Codable {
    let main: Main
    let name: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}
