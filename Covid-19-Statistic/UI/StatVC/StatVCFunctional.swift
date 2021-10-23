//
//  StatVCFunctional.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 12.10.2021.
//

import Foundation
import Charts

// создаем пустой массив для чарта
var entry: [BarChartDataEntry] = [BarChartDataEntry(x: 1, y: 0),
                                  BarChartDataEntry(x: 2, y: 0),
                                  BarChartDataEntry(x: 3, y: 0),
                                  BarChartDataEntry(x: 4, y: 0),
                                  BarChartDataEntry(x: 5, y: 0),
                                  BarChartDataEntry(x: 6, y: 0),
                                  BarChartDataEntry(x: 7, y: 0)]
//
//
//
////сохраняем его в память
////let data = try? JSONEncoder().encode(entry)
//UserDefaults.standard.set(entry, forKey: "entry")


// создаем массив с данными для будущего чарта

struct ChartsData: Codable {
    var chartData: [Double]
}



// сохраняем массив с данными в память
func createChartEntry() {
    let chartData: [Double] = [0, 0, 0, 0, 0, 0, 0]
//    let data = try? JSONEncoder().encode(chartData)
    UserDefaults.standard.set(chartData, forKey: "entry")
}

//получаем данные для чарта из памяти
func getChartEntry() -> [Double] {
    // получаем данные из UserDefaults
    let data = UserDefaults.standard.array(forKey: "entry") as! [Double]
       return data
}







