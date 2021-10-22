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

            let newData = dataTotal!.new
            // удаляем из 6 позиции данные
//            entry.remove(at: 5)
            // помещаем на 6 позицию данные из 7 позиции
//            entry.insert(entry[6], at: 5)
            print(entry[5])
            // удаляем данные из 7 позиции
            entry.remove(at: 6)
            // помещаем в 7 позицию данные текущего дня
            entry.insert(BarChartDataEntry(x: 7, y: Double(newData)), at: 6)
            // генерируем чарт
            chartCreate(entry: entry)

        }
    }
}
