//
//  GetDates.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 29.10.2021.
//

import Foundation

extension NetworkManager {
    
    func getDates() -> [String] {
        // массив для дат
        var datesArray: [String] = []
        // получаем текущую дату
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: Date()))
        let currentDate = Date(timeInterval: seconds, since: Date())
        
        // форматер для дат
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        
        // получаем даты за 6 дней до текущей даты
        
        for date in 1...6 {
            var calendar = Calendar.current
            calendar.timeZone = .current
            if let neededDate = calendar.date(byAdding: .day, value: -date, to: currentDate) {
                // форматируем дату
                let formattedDate = formatter.string(from: neededDate)
                // помещаем дату в массив
                datesArray.append(formattedDate)
            }
        }
        // возвращаем готовый массив дат
        return datesArray
    }
}
