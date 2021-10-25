//
//  NetworkManager.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 18.10.2021.
//

import Foundation
import Alamofire
import UIKit

let headers = [
    "x-rapidapi-host": apiHost,
    "x-rapidapi-key": apiKey
]

class NetworkManager {

    init(country: String, vc: UIViewController) {
        self.getTotalTodayDataForCurrentCountry(country: country)
        self.getYesterdayDataForCurrentCountry(country: country)
    }


}


