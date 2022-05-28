//
//  SetChartData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 22.10.2021.
//

import Foundation
import Charts

extension StatVC {
    
    func setChartData(isGlobal: Bool) {
        
        // Получаем данные для чарта за последние 7 дней
        
        let currentDate = Date()
        
        var currentCountryData: [ResultCountry] = []
        
        var chartArray: [Double] = []
        
        for date in 1...7 {
            let calendar = Calendar.current
            var dayComponent = DateComponents()
            dayComponent.day = (date * -1) + 1
            let resultDate = calendar.date(byAdding: dayComponent, to: currentDate)
            
            guard let resultDate = resultDate else { return }
            
            if isGlobal {
                
                // получаем данные из UserDefaults по всем странам
                if let data = UserDefaults.standard.data(forKey: "All-\(resultDate.toString())") {
                    
                    currentCountryData = try! JSONDecoder().decode([ResultCountry].self, from: data)
                    
                    if !currentCountryData.isEmpty {
                        chartArray.append(Double(currentCountryData[0].new))
                        //print("дата - \(resultDate), new - \(currentCountryData[0].new)")
                    } else {
                        chartArray.append(Double(0))
                    }
                }
                
            } else {
                
                // получаем данные из UserDefaults по текущей стране
                if let data = UserDefaults.standard.data(forKey: "\(currentCountry)-\(resultDate.toString())") {
                    
                    currentCountryData = try! JSONDecoder().decode([ResultCountry].self, from: data)
                    
                    if !currentCountryData.isEmpty {
                        chartArray.append(Double(currentCountryData[0].new))
                        //print("дата - \(resultDate), new - \(currentCountryData[0].new)")
                    } else {
                        chartArray.append(Double(0))
                    }
                }
            }
        }
        
        // разворачиваем массив
        let revertChartsData = chartArray.reduce([],{ [$1] + $0 })
        
        // помещаем данные в entry
        let entry = [BarChartDataEntry(x: 1, y: revertChartsData[0]),
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
