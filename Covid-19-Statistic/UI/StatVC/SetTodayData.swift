//
//  SetTodayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 20.10.2021.
//

import Foundation
import Charts

extension StatVC {

    func setTodayData() {
        // получаем данные из UserDefaults
        if let data = UserDefaults.standard.data(forKey: "dataTotal") {
            let dataTotal = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: data)

            // присваиваем данные
            affectedNumbers.text = String(describing: dataTotal!.affected.formattedWithSeparator)

            deathNumbers.text = String(describing: dataTotal!.death.formattedWithSeparator)

            recoveredNumbers.text = String(describing: dataTotal!.recovered.formattedWithSeparator)

            activeNumbers.text = String(describing: dataTotal!.active.formattedWithSeparator)

            seriousNumbers.text = String(describing: dataTotal!.critical.formattedWithSeparator)

            let newData = dataTotal!.new
            entry.remove(at: 6)
            entry.insert(BarChartDataEntry(x: 7, y: Double(newData)), at: 6)
            chartCreate(entry: entry)
        }
    }
}
