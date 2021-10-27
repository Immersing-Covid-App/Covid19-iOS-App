//
//  SetTodayGlobalTotalData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 28.10.2021.
//

import Foundation
import Charts

extension StatVC {

    func setTodayGlobalTotalData() {
        // получаем данные из UserDefaults
        if let data = UserDefaults.standard.data(forKey: "dataTodayGlobal") {
            let dataTotal = try? JSONDecoder().decode(CovidDataInCurrentTime.self, from: data)

            // присваиваем данные
            affectedNumbers.text = String(describing: dataTotal!.affected.formattedWithSeparator)

            deathNumbers.text = String(describing: dataTotal!.death.formattedWithSeparator)

            recoveredNumbers.text = String(describing: dataTotal!.recovered.formattedWithSeparator)

            activeNumbers.text = String(describing: dataTotal!.active.formattedWithSeparator)

            seriousNumbers.text = String(describing: dataTotal!.critical.formattedWithSeparator)
        }
    }
}

