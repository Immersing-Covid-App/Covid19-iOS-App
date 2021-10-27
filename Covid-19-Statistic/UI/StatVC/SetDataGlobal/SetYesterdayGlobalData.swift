//
//  SetYesterdayGlobalData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 28.10.2021.
//

import Foundation
import Charts

extension StatVC {

    func setYesterdayGlobalData() {
        // получаем данные из UserDefaults
        guard let yesterdayData = UserDefaults.standard.data(forKey: "dataYesterdayGlobal") else { return }
        guard let beforeYesterdayData = UserDefaults.standard.data(forKey: "dataBeforeYesterdayGlobal") else { return }

        // декодируем полученные данные
        guard let yesterdayDataForSet = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: yesterdayData) else { return }

        guard let beforeYesterdayDataForSet = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: beforeYesterdayData) else { return }

        // присваиваем данные в блок Affected
        if (yesterdayDataForSet.affected - beforeYesterdayDataForSet.affected) < 0 {
            affectedNumbers.text = "- " + String(describing: ((yesterdayDataForSet.affected - beforeYesterdayDataForSet.affected) * -1 ).formattedWithSeparator)
        } else {
            affectedNumbers.text = "+ " + String(describing: (yesterdayDataForSet.affected - beforeYesterdayDataForSet.affected).formattedWithSeparator)
        }

        // присваиваем данные в блок Death
        if (yesterdayDataForSet.death - beforeYesterdayDataForSet.death) < 0 {
            deathNumbers.text = "- " + String(describing: ((yesterdayDataForSet.death - beforeYesterdayDataForSet.death) * -1 ).formattedWithSeparator)
        } else {
            deathNumbers.text = "+ " + String(describing: (yesterdayDataForSet.death - beforeYesterdayDataForSet.death).formattedWithSeparator)
        }

        // присваиваем данные в блок Recovered
        if (yesterdayDataForSet.recovered - beforeYesterdayDataForSet.recovered) < 0 {
            recoveredNumbers.text = "- " + String(describing: ((yesterdayDataForSet.recovered - beforeYesterdayDataForSet.recovered) * -1 ).formattedWithSeparator)
        } else {
            recoveredNumbers.text = "+ " + String(describing: (yesterdayDataForSet.recovered - beforeYesterdayDataForSet.recovered).formattedWithSeparator)
        }

        // присваиваем данные в блок Active
        if (yesterdayDataForSet.active - beforeYesterdayDataForSet.active) < 0 {
            activeNumbers.text = "- " + String(describing: ((yesterdayDataForSet.active - beforeYesterdayDataForSet.active) * -1 ).formattedWithSeparator)
        } else {
            activeNumbers.text = "+ " + String(describing: (yesterdayDataForSet.active - beforeYesterdayDataForSet.active).formattedWithSeparator)
        }

        // присваиваем данные в блок Serious
        if (yesterdayDataForSet.critical - beforeYesterdayDataForSet.critical) < 0 {
            seriousNumbers.text = "- " + String(describing: ((yesterdayDataForSet.critical - beforeYesterdayDataForSet.critical) * -1 ).formattedWithSeparator)
        } else {
            seriousNumbers.text = "+ " + String(describing: (yesterdayDataForSet.critical - beforeYesterdayDataForSet.critical).formattedWithSeparator)
        }
    }
}

