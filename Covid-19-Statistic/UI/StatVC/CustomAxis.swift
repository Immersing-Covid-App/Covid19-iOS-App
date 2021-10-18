//
//  CustomAxis.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 17.10.2021.
//

import Foundation
import Charts

final class CustomLeftAxisValueFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value == 0 {
            return "0"
        } else {
            let result = "\(Int(value) / 1000)к"
            return result
        }
    }
}

final class CustomXAxisValueFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        let calendar = Calendar.current

        let dayFormater = DateFormatter()
        dayFormater.dateFormat = "dd"
        dayFormater.locale = NSLocale(localeIdentifier: "en_US") as Locale?

        let monthFormater = DateFormatter()
        monthFormater.dateFormat = "MM"
        monthFormater.locale = NSLocale(localeIdentifier: "en_US") as Locale?

        func customFormated(date: Date) -> String {
            let formatedDay = dayFormater.string(from: date as Date)
            var formatedMonth = monthFormater.string(from: date as Date)
            switch formatedMonth {
            case "01": formatedMonth = "Jan"
            case "02": formatedMonth = "Feb"
            case "03": formatedMonth = "Mar"
            case "04": formatedMonth = "Apr"
            case "05": formatedMonth = "May"
            case "06": formatedMonth = "Jun"
            case "07": formatedMonth = "Jul"
            case "08": formatedMonth = "Aug"
            case "09": formatedMonth = "Sep"
            case "10": formatedMonth = "Oct"
            case "11": formatedMonth = "Nov"
            case "12": formatedMonth = "Dec"
            default: formatedMonth = "?"
            }
            return "\(formatedMonth) \(formatedDay)"
        }

        func customDate(value: Int) -> String {
            let date = calendar.date(byAdding: .day, value: value, to: Date())
            guard let date = date else { return ""}
            return customFormated(date: date)
        }

        switch value {
        case 7:
            return customDate(value: 0)
        case 6:
            return customDate(value: -1)
        case 5:
            return customDate(value: -2)
        case 4:
            return customDate(value: -3)
        case 3:
            return customDate(value: -4)
        case 2:
            return customDate(value: -5)
        case 1:
            return customDate(value: -6)
        default:
            return ""
        }
    }
}
