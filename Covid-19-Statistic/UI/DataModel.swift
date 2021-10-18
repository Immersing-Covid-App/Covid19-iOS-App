//
//  DataModel.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 18.10.2021.
//

import Foundation
import Alamofire

var currentCountry: String = "USA"
var apiKey: String = "0bab1ef6cfmshd73bdd5a5ca4b8fp104b1ejsn527b41d2aa17"
var apiHost: String = "covid-193.p.rapidapi.com"

var new: Int = 0
var active: Int = 0
var critical: Int = 0
var recovered:Int = 0
var affected: Int = 0
var death: Int = 0

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
