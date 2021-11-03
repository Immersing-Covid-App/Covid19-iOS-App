//
//  SetTodayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 24.10.2021.
//

import Foundation

extension StatVC {

    func setTodayData(isGlobal: Bool) {

        var todayAffected: Int = 0
        var todayDeath: Int = 0
        var todayRecovered: Int = 0
        var todayActive: Int = 0
        var todayCritical: Int = 0

        var yesterdayAffected: Int = 0
        var yesterdayDeath: Int = 0
        var yesterdayRecovered: Int = 0
        var yesterdayActive: Int = 0
        var yesterdayCritical: Int = 0

        var affected: Int = 0
        var deaths: Int = 0
        var recovered: Int = 0
        var active: Int = 0
        var critical: Int = 0



        // получаем данные из UserDefaults за сегодня
        let data =  UserDefaults.standard.data(forKey: "covidData")

        if isGlobal {

            // декодируем
            do {
                    let dataTotal = try JSONDecoder().decode([CovidDataInCurrentTime].self, from: data!)

                    let country = "All"
                    // проходим по массиву данных
                    for data in dataTotal {

                        // проверяем текущую страну
                        if data.country == country {

                            todayAffected = data.affected
                            todayDeath = data.death
                            todayRecovered = data.recovered
                            todayActive = data.active
                            todayCritical = data.critical

                        }
                    }
                } catch {
                    print(error)
                }

        } else {

            // декодируем
            do {
                    let dataTotal = try JSONDecoder().decode([CovidDataInCurrentTime].self, from: data!)

                    let country = currentCountry
                    // проходим по массиву данных
                    for data in dataTotal {

                        // проверяем текущую страну
                        if data.country == country {

                            todayAffected = data.affected
                            todayDeath = data.death
                            todayRecovered = data.recovered
                            todayActive = data.active
                            todayCritical = data.critical

                        }
                    }
                } catch {
                    print(error)
                }

            }



        // получаем данные из UserDefaults за вчера
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


        if isGlobal {

            // получаем данные
            let yesterdayData =  UserDefaults.standard.data(forKey: "\(yesterdayDate)-All")

            // декодируем
            do {
                let dataTotal = try JSONDecoder().decode([CovidDataInCurrentTime].self, from: yesterdayData!)

                yesterdayAffected = dataTotal[0].affected
                yesterdayDeath = dataTotal[0].death
                yesterdayRecovered = dataTotal[0].recovered
                yesterdayActive = dataTotal[0].active
                yesterdayCritical = dataTotal[0].critical

            } catch {
                print(error)
            }

            if todayAffected < yesterdayAffected {
                affected = 0
                deaths = 0
                recovered = 0
                active = 0
                critical = 0
            } else {
                affected = todayAffected - yesterdayAffected
                deaths = todayDeath - yesterdayDeath
                recovered = todayRecovered - yesterdayRecovered
                active = todayActive - yesterdayActive
                critical = todayCritical - yesterdayCritical
            }

        } else {

            // получаем данные
            let yesterdayData =  UserDefaults.standard.data(forKey: "\(yesterdayDate)-\(currentCountry)")

            // декодируем
            do {
                let dataTotal = try JSONDecoder().decode([CovidDataInCurrentTime].self, from: yesterdayData!)

                yesterdayAffected = dataTotal[0].affected
                yesterdayDeath = dataTotal[0].death
                yesterdayRecovered = dataTotal[0].recovered
                yesterdayActive = dataTotal[0].active
                yesterdayCritical = dataTotal[0].critical

            } catch {
                print(error)
            }





        }



        
// удалить потом
        print("today",todayAffected,
              todayDeath,
              todayRecovered,
              todayActive,
              todayCritical)

        print("yesterday",yesterdayAffected,
              yesterdayDeath,
              yesterdayRecovered,
              yesterdayActive,
              yesterdayCritical)


        if todayAffected < yesterdayAffected {
            affected = 0
            deaths = 0
            recovered = 0
            active = 0
            critical = 0
        } else {
            affected = todayAffected - yesterdayAffected
            deaths = todayDeath - yesterdayDeath
            recovered = todayRecovered - yesterdayRecovered
            active = todayActive - yesterdayActive
            critical = todayCritical - yesterdayCritical
        }


        // присваиваем данные в блок Affected
        affectedNumbers.text = String(describing: affected.formattedWithSeparator)

        // присваиваем данные в блок Death
        deathNumbers.text = String(describing: deaths.formattedWithSeparator)

        // присваиваем данные в блок Recovered
        recoveredNumbers.text = String(describing: recovered.formattedWithSeparator)

        // присваиваем данные в блок Active
        activeNumbers.text = String(describing: active.formattedWithSeparator)

        // присваиваем данные в блок Serious
        seriousNumbers.text = String(describing: critical.formattedWithSeparator)
    }
}
