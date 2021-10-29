//
//  NetworkManager.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 18.10.2021.
//

import Foundation
import Alamofire
import UIKit



class NetworkManager {

    let headers = [
        "x-rapidapi-host": apiHost,
        "x-rapidapi-key": apiKey
    ]

    init(country: String, vc: UIViewController) {
//        self.getTodayDataForCurrentCountry(country: country)
//        self.getYesterdayDataForCurrentCountry(country: country)
//        self.getBeforeYesterdayDataForCurrentCountry(country: country)
//        self.getChartDataForCurrentCountry(country: country)
//        self.getTodayDataForGlobal(country: "All")
//        self.getYesterdayDataForGlobal(country: "All")
//        self.getBeforeYesterdayDataForGlobal(country: "All")
//        self.getChartDataForGlobal(country: "All")
        self.getData(date: "")

   /*     let dates = getDates()

        for i in dates {
            self.getData(date: i)
        } */
    }
}
