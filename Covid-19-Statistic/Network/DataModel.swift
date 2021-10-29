//
//  DataModel.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 18.10.2021.
//

import Foundation
import Charts

var currentCountry: String = "USA"

// создаем массив для данных чарта
var chartData: [Double] = [0, 0, 0, 0, 0, 0, 0]

// структуры для JSON Decode
struct CovidData: Codable {
    var response: [Response]?
}

struct Response: Codable {
    var country: String?
    var cases: Cases?
    var deaths: Deaths?
    var time: String?
}
struct Cases: Codable {
    var new: String?
    var active: Int?
    var critical: Int?
    var recovered: Int?
    var total: Int?
}
struct Deaths: Codable {
    var new: String?
    var total: Int?
}

// структура для данных
struct CovidDataInCurrentTime: Codable {
    var new: Int
    var active: Int
    var critical: Int
    var recovered:Int
    var affected: Int
    var death: Int
    var country: String
}

// создаем пустой массив для чарта
var entry: [BarChartDataEntry] = [BarChartDataEntry(x: 1, y: 0),
                                  BarChartDataEntry(x: 2, y: 0),
                                  BarChartDataEntry(x: 3, y: 0),
                                  BarChartDataEntry(x: 4, y: 0),
                                  BarChartDataEntry(x: 5, y: 0),
                                  BarChartDataEntry(x: 6, y: 0),
                                  BarChartDataEntry(x: 7, y: 0)]
