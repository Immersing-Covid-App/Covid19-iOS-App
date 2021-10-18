//
//  GetData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 19.10.2021.
//

import Foundation

func getData(country: String) {
    let networkManager = NetworkManager()
    networkManager.getTodayStatisticForCurrentCountry(country: country)
}
