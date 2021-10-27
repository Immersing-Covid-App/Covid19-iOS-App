//
//  SetChartData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 22.10.2021.
//

import Foundation
import Charts

extension StatVC {

    func setChartData() {

        // получаем данные из UserDefaults
        guard let _ = UserDefaults.standard.array(forKey: "chartData") else { return }
        let chartsData = UserDefaults.standard.array(forKey: "chartData")  as? [Double] ?? [Double]()

        // разворачиваем массив
        let revertChartsData = chartsData.reduce([],{ [$1] + $0 })

        // помещаем данные в entry
        entry = [BarChartDataEntry(x: 1, y: revertChartsData[0]),
                 BarChartDataEntry(x: 2, y: revertChartsData[1]),
                 BarChartDataEntry(x: 3, y: revertChartsData[2]),
                 BarChartDataEntry(x: 4, y: revertChartsData[3]),
                 BarChartDataEntry(x: 5, y: revertChartsData[4]),
                 BarChartDataEntry(x: 6, y: revertChartsData[5]),
                 BarChartDataEntry(x: 7, y: revertChartsData[6]),
        ]

        // генерируем чарт

        chartCreate(entry: entry)
        barChart.animate(yAxisDuration: 2)
    }

}
