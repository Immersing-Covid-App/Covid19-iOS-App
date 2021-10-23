//
//  SetChartData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 22.10.2021.
//

import Foundation
import Charts

extension StatVC {

    func SetChartData() {

        // получаем данные из UserDefaults
        if let data = UserDefaults.standard.data(forKey: "dataTotal") {
            let dataTotal = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: data)

            let chartDataArray = getChartEntry()
            print(chartDataArray)

            entry = [BarChartDataEntry(x: 0, y: chartDataArray[0]),
                     BarChartDataEntry(x: 0, y: chartDataArray[1]),
                     BarChartDataEntry(x: 0, y: chartDataArray[2]),
                     BarChartDataEntry(x: 0, y: chartDataArray[3]),
                     BarChartDataEntry(x: 0, y: chartDataArray[4]),
                     BarChartDataEntry(x: 0, y: chartDataArray[5]),
                     BarChartDataEntry(x: 0, y: chartDataArray[6]),
            ]

            

            let newData = dataTotal!.new
            // удаляем данные из 7 позиции
            entry.remove(at: 6)
            // помещаем в 7 позицию данные текущего дня
            entry.insert(BarChartDataEntry(x: 7, y: Double(newData)), at: 6)
            // генерируем чарт
            chartCreate(entry: entry)

        }
    }
}
