//
//  ForecastData.swift
//  Present Service Contact ТЗ
//
//  Created by Pavel Krigin on 10.09.2024.
//

import Foundation

struct ForecastData: Codable {
    let list: [DailyForecast]
}

struct DailyForecast: Codable {
    let temp: Temperature
    let humidity: Int
}

struct Temperature: Codable {
    let day: Double
}
