//
//  GetDataForChart.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 27.10.2021.
//

import Foundation
import Alamofire
import UIKit

extension NetworkManager {

    // метод получения данных выбранной страны за вчера
    func getChartDataForCurrentCountry(country: String) {

        let calendar = Calendar.current
        // форматируем даты
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        // получаем текущую дату
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: Date()))
        let currentDate = Date(timeInterval: seconds, since: Date())

        // получаем данные new текущей даты
        let currenURL = "https://\(apiHost)/statistics?country=\(country)"

        AF.request(currenURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).responseJSON { (responceData) in

            guard let data = responceData.data else {
                NotificationCenter.default.post(name: Notification.Name("errorGetData"), object: nil)
                return }

            do {
                let covidData = try JSONDecoder().decode(CovidData.self, from: data
                )

                guard let gotData = covidData.response else { return }

                guard let gotDataNew = gotData[0].cases?.new else { return }
                let newData = gotDataNew.customizeNew()

                // помещаем данные в массив

                // сравниваем дату
                if currentDate == Date() {
                    chartData.remove(at: 0)
                    chartData.insert(Double(newData), at: 0)
                    //сохраняем в память
                    UserDefaults.standard.set(chartData, forKey: "chartData")
                } else {
                    chartData.remove(at: 0)
                    chartData.insert(Double(0), at: 0)
                    //сохраняем в память
                    UserDefaults.standard.set(chartData, forKey: "chartData")
                }

            } catch {
                print(error.localizedDescription)
            }

        }


        // получаем данные за 6 дней до текущей даты
        for i in 1...6 {

            // получаем дату
            guard let date = calendar.date(byAdding: .day, value: -i, to: currentDate) else { return }

            // сохраняем отформатированную дату в строку
            let formatDate = formatter.string(from: date)

            // создаем URL запроса
            let currenURL = "https://\(apiHost)/history?country=\(country)&day=\(formatDate)"


            // выполняем запрос на сервер
            AF.request(currenURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).responseJSON { (responceData) in

                guard let data = responceData.data else {
                    NotificationCenter.default.post(name: Notification.Name("errorGetData"), object: nil)
                    return }

                do {
                    let covidData = try JSONDecoder().decode(CovidData.self, from: data
                    )

                    guard let gotData = covidData.response else { return }
                    guard let gotDataNew = gotData[0].cases?.new else { return }
                    let newData = gotDataNew.customizeNew()

                    // помещаем данные в массив
                    chartData.remove(at: i)
                    chartData.insert(Double(newData), at: i)

                    //сохраняем в память
                    UserDefaults.standard.set(chartData, forKey: "chartData")

                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
