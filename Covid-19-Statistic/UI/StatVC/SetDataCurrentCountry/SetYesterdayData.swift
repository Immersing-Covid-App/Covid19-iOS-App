//
//  SetYesterdayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 27.10.2021.
//

import Foundation

extension StatVC {

    func setYesterdayData() {

        // получаем вчерашнюю и позавчерашнюю даты в формате yyyy-mm-dd
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

        // позавчерашняя дата
        guard let beforeYesterday = calendar.date(byAdding: .day, value: -2, to: currentDate) else {
            print("не удалось получить вчерашнюю дату")
            return }

        // форматируем даты
        let yesterdayDate = formatter.string(from: yesterday)
        let beforeYesterdayDate = formatter.string(from: beforeYesterday)

        // получаем данные из UserDefaults за сегодня и вчера
        let dataYesterday = setTodayTotalData(date: yesterdayDate)
        let dataBeforeYesterday = setTodayTotalData(date: beforeYesterdayDate)

        // присваиваем данные в блок Affected
        if (dataYesterday.affected - dataBeforeYesterday.affected) > 0 {
            affectedNumbers.text = "+ " + String(describing: (dataYesterday.affected - dataBeforeYesterday.affected).formattedWithSeparator)
        } else {
            affectedNumbers.text = "- " + String(describing: ((dataYesterday.affected - dataBeforeYesterday.affected) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Death
        if (dataYesterday.death - dataBeforeYesterday.death) > 0 {
            deathNumbers.text = "+ " + String(describing: (dataYesterday.death - dataBeforeYesterday.death).formattedWithSeparator)
        } else {
            deathNumbers.text = "- " + String(describing: ((dataYesterday.death - dataBeforeYesterday.death) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Recovered
        if (dataYesterday.recovered - dataBeforeYesterday.recovered) > 0 {
            recoveredNumbers.text = "+ " + String(describing: (dataYesterday.recovered - dataBeforeYesterday.recovered).formattedWithSeparator)
        } else {
            recoveredNumbers.text = "- " + String(describing: ((dataYesterday.recovered - dataBeforeYesterday.recovered) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Active
        if (dataYesterday.active - dataBeforeYesterday.active) > 0 {
            activeNumbers.text = "+ " + String(describing: (dataYesterday.active - dataBeforeYesterday.active).formattedWithSeparator)
        } else {
            activeNumbers.text = "- " + String(describing: ((dataYesterday.active - dataBeforeYesterday.active) * -1).formattedWithSeparator)
        }

        // присваиваем данные в блок Serious
        if (dataYesterday.critical - dataBeforeYesterday.critical) > 0 {
            seriousNumbers.text = "+ " + String(describing: (dataYesterday.critical - dataBeforeYesterday.critical).formattedWithSeparator)
        } else {
            seriousNumbers.text = "- " + String(describing: ((dataYesterday.critical - dataBeforeYesterday.critical) * -1).formattedWithSeparator)
        }
    }
}
