//
//  SetTodayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 24.10.2021.
//

import Foundation

extension StatVC {

    func setTodayData() {

        // получаем текущую и вчерашнюю даты в формате yyyy-mm-dd
        // форматер для дат
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        var calendar = Calendar.current
        calendar.timeZone = .current

        // текущая дата
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: Date()))
        let currentDate = Date(timeInterval: seconds, since: Date())

        // вчерашняя дата
        guard let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate) else {
            print("не удалось получить вчерашнюю дату")
            return }

        // форматируем вчерашнюю дату
        let yesterdayDate = formatter.string(from: yesterday)

        // получаем данные из UserDefaults за сегодня и вчера
        let dataToday = setTodayTotalData()
        let dataYesterday = setTodayTotalData(date: yesterdayDate)

        print("сегодняшняя дата - \(dataToday.affected)\n вчерашняя дата - \(dataYesterday.affected)")

        // присваиваем данные в блок Affected
        if (dataToday.affected - dataYesterday.affected) > 0 {
            affectedNumbers.text = "+ " + String(describing: (dataToday.affected - dataYesterday.affected).formattedWithSeparator)
        } else {
            affectedNumbers.text = "- " + String(describing: ((dataToday.affected - dataYesterday.affected) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Death
        if (dataToday.death - dataYesterday.death) > 0 {
            deathNumbers.text = "+ " + String(describing: (dataToday.death - dataYesterday.death).formattedWithSeparator)
        } else {
            deathNumbers.text = "- " + String(describing: ((dataToday.death - dataYesterday.death) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Recovered
        if (dataToday.recovered - dataYesterday.recovered) > 0 {
            recoveredNumbers.text = "+ " + String(describing: (dataToday.recovered - dataYesterday.recovered).formattedWithSeparator)
        } else {
            recoveredNumbers.text = "- " + String(describing: ((dataToday.recovered - dataYesterday.recovered) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Active
        if (dataToday.active - dataYesterday.active) > 0 {
            activeNumbers.text = "+ " + String(describing: (dataToday.active - dataYesterday.active).formattedWithSeparator)
        } else {
            activeNumbers.text = "- " + String(describing: ((dataToday.active - dataYesterday.active) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Serious
        if (dataToday.critical - dataYesterday.critical) > 0 {
            seriousNumbers.text = "+ " + String(describing: (dataToday.critical - dataYesterday.critical).formattedWithSeparator)
        } else {
            seriousNumbers.text = "- " + String(describing: ((dataToday.critical - dataYesterday.critical) * -1).formattedWithSeparator)
        }
    }
}
