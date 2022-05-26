//
//  SetTodayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 24.10.2021.
//

import Foundation

extension StatVC {
    
    func setTodayData(isGlobal: Bool) {
        
        var currentCountryDataToday: [ResultCountry] = []
        var currentCountryDataYesterday: [ResultCountry] = []
        
        // получаем текущую дату в виде строки
        let currentDate = Date().toString()
        
        if isGlobal {
            
            // получаем данные из UserDefaults по всем странам за сегодня
            if let data = UserDefaults.standard.data(forKey: "All-\(currentDate)") {
                currentCountryDataToday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - All-\(currentDate)")
            }
            
            // получаем данные из UserDefaults по всем странам за вчера
            let calendar = Calendar.current
            var dayComponent = DateComponents()
            dayComponent.day = -1
            guard let yesterdayDate = calendar.date(byAdding: dayComponent, to: Date())?.toString() else { return }
            
            if let data = UserDefaults.standard.data(forKey: "All-\(yesterdayDate)") {
                currentCountryDataYesterday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - All-\(yesterdayDate)")
            }
            
        } else {
            
            // получаем данные из UserDefaults по текущей стране за сегодня
            if let data = UserDefaults.standard.data(forKey: "\(currentCountry)-\(currentDate)") {
                currentCountryDataToday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - \(currentCountry)-\(currentDate)")
            }
            // получаем данные из UserDefaults по текущей стране за вчера
            let calendar = Calendar.current
            var dayComponent = DateComponents()
            dayComponent.day = -1
            guard let yesterdayDate = calendar.date(byAdding: dayComponent, to: Date())?.toString() else { return }
            
            if let data = UserDefaults.standard.data(forKey: "\(currentCountry)-\(yesterdayDate)") {
                currentCountryDataYesterday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - \(currentCountry)-\(yesterdayDate)")
            }
            
        }
        
        if currentCountryDataToday.isEmpty == false && currentCountryDataYesterday.isEmpty == false {
            // присваиваем данные в блок Affected
            if let totalToday = currentCountryDataToday[0].total, let yesterdayTotal = currentCountryDataYesterday[0].total {
                affectedNumbers.text = "+" + (totalToday - yesterdayTotal).formattedWithSeparator
            }
            
            // присваиваем данные в блок Death
            if let deathToday = currentCountryDataToday[0].deathsTotal, let deathYesterday = currentCountryDataYesterday[0].deathsTotal {
                deathNumbers.text =  "+" + (deathToday - deathYesterday).formattedWithSeparator
            }
            
            // присваиваем данные в блок Recovered
            if let recoveredToday = currentCountryDataToday[0].recovered, let recoveredYesterday = currentCountryDataYesterday[0].recovered {
                recoveredNumbers.text = "+" + (recoveredToday - recoveredYesterday).formattedWithSeparator
            }
            
            // присваиваем данные в блок Active
            if let activeToday = currentCountryDataToday[0].active, let activeYesterday = currentCountryDataYesterday[0].active {
                
                if (activeToday - activeYesterday) > 0 {
                    activeNumbers.text = "+" + (activeToday - activeYesterday).formattedWithSeparator
                } else if (activeToday - activeYesterday) < 0 {
                    activeNumbers.text = (activeToday - activeYesterday).formattedWithSeparator
                } else {
                    activeNumbers.text = "0"
                }
            }
            
            // присваиваем данные в блок Serious
            if let seriousToday = currentCountryDataToday[0].critical, let seriousYesterday = currentCountryDataYesterday[0].critical {
                
                if (seriousToday - seriousYesterday) > 0 {
                    seriousNumbers.text = "+" + (seriousToday - seriousYesterday).formattedWithSeparator
                } else if (seriousToday - seriousYesterday) < 0{
                    seriousNumbers.text = (seriousToday - seriousYesterday).formattedWithSeparator
                } else {
                    seriousNumbers.text = "0"
                }
            }
            
        } else {
            self.postError()
        }
    }
}
