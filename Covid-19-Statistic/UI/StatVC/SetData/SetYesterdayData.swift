//
//  SetYesterdayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 27.10.2021.
//

import Foundation

extension StatVC {
    
    func setYesterdayData(isGlobal: Bool) {
        
        var currentCountryDataYesterday: [ResultCountry] = []
        var currentCountryDataDayBeforeYesterday: [ResultCountry] = []
        
        if isGlobal {
            
            // получаем данные из UserDefaults по всем странам за вчера
            let calendar = Calendar.current
            var dayComponent = DateComponents()
            dayComponent.day = -1
            guard let yesterdayDate = calendar.date(byAdding: dayComponent, to: Date())?.toString() else { return }
            
            if let data = UserDefaults.standard.data(forKey: "All-\(yesterdayDate)") {
                currentCountryDataYesterday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - All-\(yesterdayDate)")
            }
            
            // получаем данные из UserDefaults по всем странам за позавчера
            dayComponent.day = -2
            guard let dayBeforeYesterdayDate = calendar.date(byAdding: dayComponent, to: Date())?.toString() else { return }
            
            if let data = UserDefaults.standard.data(forKey: "All-\(dayBeforeYesterdayDate)") {
                currentCountryDataDayBeforeYesterday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - All-\(dayBeforeYesterdayDate)")
            }
            
            
            
        } else {
            
            // получаем данные из UserDefaults по текущей стране за вчера
            let calendar = Calendar.current
            var dayComponent = DateComponents()
            dayComponent.day = -1
            guard let yesterdayDate = calendar.date(byAdding: dayComponent, to: Date())?.toString() else { return }
            
            if let data = UserDefaults.standard.data(forKey: "\(currentCountry)-\(yesterdayDate)") {
                currentCountryDataYesterday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - \(currentCountry)-\(yesterdayDate)")
            }
            
            // получаем данные из UserDefaults по текущей стране за позавчера
            dayComponent.day = -2
            guard let dayBeforeYesterdayDate = calendar.date(byAdding: dayComponent, to: Date())?.toString() else { return }
            
            if let data = UserDefaults.standard.data(forKey: "\(currentCountry)-\(dayBeforeYesterdayDate)") {
                currentCountryDataDayBeforeYesterday = try! JSONDecoder().decode([ResultCountry].self, from: data)
                print("данные получены по ключу - \(currentCountry)-\(dayBeforeYesterdayDate)")
            }
            
        }
        
        if currentCountryDataYesterday.isEmpty == false && currentCountryDataDayBeforeYesterday.isEmpty == false {
            
            // присваиваем данные в блок Affected
            
            if let totalYesterday = currentCountryDataYesterday[0].total, let totalDayBeforeYesterday = currentCountryDataDayBeforeYesterday[0].total {
                affectedNumbers.text = "+" + (totalYesterday - totalDayBeforeYesterday).formattedWithSeparator
            }
            
            // присваиваем данные в блок Death
            if let deathYesterday = currentCountryDataYesterday[0].deathsTotal, let deathDayBeforeYesterday = currentCountryDataDayBeforeYesterday[0].deathsTotal {
                deathNumbers.text =  "+" + (deathYesterday - deathDayBeforeYesterday).formattedWithSeparator
            }
            
            // присваиваем данные в блок Recovered
            if let recoveredYesterday = currentCountryDataYesterday[0].recovered, let recoveredDayBeforeYesterday = currentCountryDataDayBeforeYesterday[0].recovered {
                recoveredNumbers.text = "+" + (recoveredYesterday - recoveredDayBeforeYesterday).formattedWithSeparator
            }
            
            // присваиваем данные в блок Active
            if let activeYesterday = currentCountryDataYesterday[0].active, let activeDayBeforeYesterday = currentCountryDataDayBeforeYesterday[0].active {
                
                if (activeYesterday - activeDayBeforeYesterday) > 0 {
                    activeNumbers.text = "+" + (activeYesterday - activeDayBeforeYesterday).formattedWithSeparator
                } else if (activeYesterday - activeDayBeforeYesterday) < 0 {
                    activeNumbers.text = (activeYesterday - activeDayBeforeYesterday).formattedWithSeparator
                } else {
                    activeNumbers.text = "0"
                }
            }
            
            // присваиваем данные в блок Serious
            if let seriousYesterday = currentCountryDataYesterday[0].critical, let seriousDayBeforeYesterday = currentCountryDataDayBeforeYesterday[0].critical {
                
                if (seriousYesterday - seriousDayBeforeYesterday) > 0 {
                    seriousNumbers.text = "+" + (seriousYesterday - seriousDayBeforeYesterday).formattedWithSeparator
                } else if (seriousYesterday - seriousDayBeforeYesterday) < 0{
                    seriousNumbers.text = (seriousYesterday - seriousDayBeforeYesterday).formattedWithSeparator
                } else {
                    seriousNumbers.text = "0"
                }
            }
            
        } else {
            self.postError()
        }
    }
}
