//
//  SetTodayTotalData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 20.10.2021.
//

import Foundation
import Charts

extension StatVC {

    func setTodayTotalData() {
        // получаем данные из UserDefaults
        let data = UserDefaults.standard.data(forKey: "covidData")
        // декодируем
        do {
            let dataTotal = try JSONDecoder().decode([CovidDataInCurrentTime].self, from: data!)

            // проходим по массиву данных
            for data in dataTotal {

                // проверяем текущую страну
                if data.country == currentCountry {
                    // присваиваем данные
                    affectedNumbers.text = String(describing: data.affected.formattedWithSeparator)

                    deathNumbers.text = String(describing: data.death.formattedWithSeparator)

                    recoveredNumbers.text = String(describing: data.recovered.formattedWithSeparator)

                    activeNumbers.text = String(describing: data.active.formattedWithSeparator)

                    seriousNumbers.text = String(describing: data.critical.formattedWithSeparator)
                }
            }
        } catch {
            print(error)
        }
    }
}
