//
//  DataModel.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 18.10.2021.
//

import Foundation

var currentCountry: String = "USA"

// структуры для JSON Decode
struct CovidData: Decodable {
    var response: [Response]?
}
struct Response: Decodable {
    var country: String?
    var cases: Cases?
    var deaths: Deaths?
    var time: String?
}
struct Cases: Decodable {
    var new: String?
    var active: Int?
    var critical: Int?
    var recovered: Int?
    var total: Int?
}
struct Deaths: Decodable {
    var new: String?
    var total: Int
}


// структура для данных
struct CovidDataInCurrentTime: Codable {
    var new: Int
    var active: Int
    var critical: Int
    var recovered:Int
    var affected: Int
    var death: Int
    var date: Date
}



