//
//  SetTotalData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 20.10.2021.
//

import Foundation


extension StatVC {
    
    func setTotalData(isGlobal: Bool) {
        
        var currentCountryData: [ResultCountry] = []
        
        // получаем текущую дату в виде строки
        let currentDate = Date().toString()
        
        if isGlobal {
            
            // получаем данные из UserDefaults по всем странам
            if let data = UserDefaults.standard.data(forKey: "All-\(currentDate)") {
                currentCountryData = try! JSONDecoder().decode([ResultCountry].self, from: data)
                //print("данные получены по ключу - All-\(currentDate)")
            }
            
        } else {
            
            // получаем данные из UserDefaults по текущей стране
            if let data = UserDefaults.standard.data(forKey: "\(currentCountry)-\(currentDate)") {
                currentCountryData = try! JSONDecoder().decode([ResultCountry].self, from: data)
                //print("данные получены по ключу - \(currentCountry)-\(currentDate)")
            }
        }
        
        if currentCountryData.isEmpty == false {
            // присваиваем данные в блок Affected
            
            affectedNumbers.text = currentCountryData[0].total?.formattedWithSeparator
            
            // присваиваем данные в блок Death
            deathNumbers.text = currentCountryData[0].deathsTotal?.formattedWithSeparator
            
            // присваиваем данные в блок Recovered
            recoveredNumbers.text = currentCountryData[0].recovered?.formattedWithSeparator
            
            // присваиваем данные в блок Active
            activeNumbers.text = currentCountryData[0].active?.formattedWithSeparator
            
            // присваиваем данные в блок Serious
            seriousNumbers.text = currentCountryData[0].critical?.formattedWithSeparator
        } else {
            self.postError()
        }
        

        
        
       
    }
    
}
