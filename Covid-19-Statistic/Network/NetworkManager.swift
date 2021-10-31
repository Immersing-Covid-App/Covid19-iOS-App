//
//  NetworkManager.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 18.10.2021.
//

import Foundation
import Alamofire

class NetworkManager {

    let headers = [
        "x-rapidapi-host": apiHost,
        "x-rapidapi-key": apiKey
    ]

    init(country: String, vc: UIViewController) {

        self.getCountries()

        self.getData(date: "")


        let dates = getDates()
        for i in dates {
            self.getData(date: i)
        }
    }
}
