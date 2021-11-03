////
////  SetTodayGlobalData.swift
////  Covid-19-Statistic
////
////  Created by Dmitrii Lobanov on 28.10.2021.
////
//
//import Foundation
//import Charts
//
//extension StatVC {
//
//    func setTodayGlobalData() {
//        // получаем данные из UserDefaults
//        guard let todayData = UserDefaults.standard.data(forKey: "dataTodayGlobal") else { return }
//        guard let yesterdayData = UserDefaults.standard.data(forKey: "dataYesterdayGlobal") else { return }
//
//        // декодируем полученные данные
//        guard let todayDataForSet = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: todayData) else { return }
//
//        guard let yesterdayDataForSet = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: yesterdayData) else { return }
//
//        // присваиваем данные в блок Affected
//        if (todayDataForSet.affected - yesterdayDataForSet.affected) < 0 {
//            affectedNumbers.text = "- " + String(describing: ((todayDataForSet.affected - yesterdayDataForSet.affected) * -1 ).formattedWithSeparator)
//        } else {
//            affectedNumbers.text = "+ " + String(describing: (todayDataForSet.affected - yesterdayDataForSet.affected).formattedWithSeparator)
//        }
//
//        // присваиваем данные в блок Death
//        if (todayDataForSet.death - yesterdayDataForSet.death) < 0 {
//            deathNumbers.text = "- " + String(describing: ((todayDataForSet.death - yesterdayDataForSet.death) * -1 ).formattedWithSeparator)
//        } else {
//            deathNumbers.text = "+ " + String(describing: (todayDataForSet.death - yesterdayDataForSet.death).formattedWithSeparator)
//        }
//
//        // присваиваем данные в блок Recovered
//        if (todayDataForSet.recovered - yesterdayDataForSet.recovered) < 0 {
//            recoveredNumbers.text = "- " + String(describing: ((todayDataForSet.recovered - yesterdayDataForSet.recovered) * -1 ).formattedWithSeparator)
//        } else {
//            recoveredNumbers.text = "+ " + String(describing: (todayDataForSet.recovered - yesterdayDataForSet.recovered).formattedWithSeparator)
//        }
//
//        // присваиваем данные в блок Active
//        if (todayDataForSet.active - yesterdayDataForSet.active) < 0 {
//            activeNumbers.text = "- " + String(describing: ((todayDataForSet.active - yesterdayDataForSet.active) * -1 ).formattedWithSeparator)
//        } else {
//            activeNumbers.text = "+ " + String(describing: (todayDataForSet.active - yesterdayDataForSet.active).formattedWithSeparator)
//        }
//
//        // присваиваем данные в блок Serious
//        if (todayDataForSet.critical - yesterdayDataForSet.critical) < 0 {
//            seriousNumbers.text = "- " + String(describing: ((todayDataForSet.critical - yesterdayDataForSet.critical) * -1 ).formattedWithSeparator)
//        } else {
//            seriousNumbers.text = "+ " + String(describing: (todayDataForSet.critical - yesterdayDataForSet.critical).formattedWithSeparator)
//        }
//    }
//}
