//
//  SetTodayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 24.10.2021.
//

import Foundation
import Charts

extension StatVC {

    func SetTodayData() {
        // получаем данные из UserDefaults
        guard let todayData = UserDefaults.standard.data(forKey: "dataTotal") else { return }
        guard let yesterdayData = UserDefaults.standard.data(forKey: "dataYesterday") else { return }

        // декодируем полученные данные
        guard let todayDataForSet = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: todayData) else { return }

        guard let yesterdayDataForSet = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: yesterdayData) else { return }


        print("отображаем сегодняшние данные")
        print((todayDataForSet.death, yesterdayDataForSet.death))
        // присваиваем данные
        affectedNumbers.text = String(describing: (todayDataForSet.affected - yesterdayDataForSet.affected).formattedWithSeparator)

        deathNumbers.text = String(describing: (todayDataForSet.death - yesterdayDataForSet.death).formattedWithSeparator)

        recoveredNumbers.text = String(describing: (todayDataForSet.recovered - yesterdayDataForSet.recovered).formattedWithSeparator)

        activeNumbers.text = String(describing: (todayDataForSet.active - yesterdayDataForSet.active).formattedWithSeparator)

        seriousNumbers.text = String(describing: (todayDataForSet.critical - yesterdayDataForSet.critical).formattedWithSeparator)


    }
}

