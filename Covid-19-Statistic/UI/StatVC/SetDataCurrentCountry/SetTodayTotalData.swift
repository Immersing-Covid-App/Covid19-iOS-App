//
//  SetTodayTotalData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 20.10.2021.
//

import Foundation

extension StatVC {

    func setTodayTotalData(date: String = "") -> CovidDataInCurrentTime {

        var returnData: CovidDataInCurrentTime?

        // получаем данные из UserDefaults

        let data: Data?

        // проверяем передана ли в метод дата
        if date == "" {
            data = UserDefaults.standard.data(forKey: "covidData")
        }
        else {
            data = UserDefaults.standard.data(forKey: "\(date)-\(currentCountry)")
        }
        // декодируем
        do {
            let dataTotal = try JSONDecoder().decode([CovidDataInCurrentTime].self, from: data!)

            // проходим по массиву данных
            for data in dataTotal {

                // проверяем текущую страну
                if data.country == currentCountry {
                    // присваиваем данные в блок Affected
                    affectedNumbers.text = String(describing: data.affected.formattedWithSeparator)

                    // присваиваем данные в блок Death
                    deathNumbers.text = String(describing: data.death.formattedWithSeparator)

                    // присваиваем данные в блок Recovered
                    recoveredNumbers.text = String(describing: data.recovered.formattedWithSeparator)

                    // присваиваем данные в блок Active
                    activeNumbers.text = String(describing: data.active.formattedWithSeparator)

                    // присваиваем данные в блок Serious
                    seriousNumbers.text = String(describing: data.critical.formattedWithSeparator)

                    returnData = data
                }
            }
        } catch {
            print(error)
        }
        guard let result = returnData else {return CovidDataInCurrentTime(new: 0, active: 0, critical: 0, recovered: 0, affected: 0, death: 0, country: "")}
        return result
    }
}
