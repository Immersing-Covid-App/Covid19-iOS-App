//
//  GetAllNeedData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 06.02.2022.
//

import Foundation

extension NetworkManager {
    
    func getAllNeedData() {

        let currentDate = Date()
        
        self.getTodayDataForCurrentCountry(country: currentCountry, date: currentDate)
        self.getTodayDataForCurrentCountry(country: "All", date: currentDate)
        
        
        for date in 1...7 {
            let calendar = Calendar.current
            var dayComponent = DateComponents()
            dayComponent.day = date * -1
            let resultDate = calendar.date(byAdding: dayComponent, to: currentDate)
            guard let resultDate = resultDate else { return }
            self.getTodayDataForCurrentCountry(country: currentCountry, date: resultDate)
            self.getTodayDataForCurrentCountry(country: "All", date: resultDate)
            
        }
        
    }
}
