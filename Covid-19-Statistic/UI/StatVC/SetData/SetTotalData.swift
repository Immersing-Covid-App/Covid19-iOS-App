//
//  SetTotalData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 20.10.2021.
//

import Foundation

extension StatVC {

    func setTotalData(isGlobal: Bool) {

        // получаем данные из UserDefaults
        let data =  UserDefaults.standard.data(forKey: "covidData")

        // декодируем
        do {
            let dataTotal = try JSONDecoder().decode([CovidDataInCurrentTime].self, from: data!)

            // проходим по массиву данных
            for data in dataTotal {

                if !isGlobal {

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
                    }

                } else {

                    // проверяем текущую страну
                    if data.country == "All" {
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
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}
