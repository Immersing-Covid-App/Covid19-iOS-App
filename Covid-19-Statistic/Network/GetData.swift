//
//  GetCurrentData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 29.10.2021.
//

import Foundation
import Alamofire


extension NetworkManager {

    // метод получения данных по всему миру на момент запроса
    func getData(date: String) {

        // URL
        let url = { () -> String in
            if date == "" {
                return "https://\(apiHost)/statistics"
            } else {
                return "https://\(apiHost)/history?country=\(currentCountry)&day=\(date)"
            }
        }

        // запрос данных
        AF.request(url(), method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).responseJSON { (responceData) in

            // проверяем, получены ли данные
            guard let data = responceData.data else {
                // если нет, вызываем алерт
                NotificationCenter.default.post(name: Notification.Name("errorGetData"), object: nil)
                return }

            // кодируем данные для сохранения
            do {
                let covidData = try JSONDecoder().decode(CovidData.self, from: data)

                // создаем массив объектов для сохранения
                var covidDataObject: [CovidDataInCurrentTime] = []

                guard let responces = covidData.response else { return }

                for responce in responces {

                    let new = responce.cases?.new?.customizeNew() ?? 0
                    let active = responce.cases?.active ?? 0
                    let critical = responce.cases?.critical ?? 0
                    let recovered = responce.cases?.recovered ?? 0
                    let affected = responce.cases?.total ?? 0
                    let death = responce.deaths?.total ?? 0
                    let country = responce.country ?? "No country"

                    let data = CovidDataInCurrentTime(
                        new: new,
                        active: active,
                        critical: critical,
                        recovered: recovered,
                        affected: affected,
                        death: death,
                        country: country)

                    covidDataObject.append(data)
                }

                //сохраняем в память
                do {
                    let data = try JSONEncoder().encode(covidDataObject)
                    if date != "" {
                        UserDefaults.standard.set(data, forKey: "\(date)-\(currentCountry)")
                        print("данные за число \(String(describing: date)) сохранены по ключу: \(date)-\(currentCountry)")
                    } else {
                        UserDefaults.standard.set(data, forKey: "covidData")
                        print("глобальные данные за сегодня сохранены по ключу: covidData")
                    }
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
        }
    }
}



//
//extension NetworkManager {
//
//    // метод получения данных по всему миру на момент запроса
//    func getCurrentData() {
//
//        // URL
//        let url = "https://\(apiHost)/statistics"
//
//        // запрос данных
//        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).responseJSON { (responceData) in
//
//            // проверяем, получены ли данные
//            guard let data = responceData.data else {
//                // если нет, вызываем алерт
//                NotificationCenter.default.post(name: Notification.Name("errorGetData"), object: nil)
//                return }
//
//            // кодируем данные для сохранения
//            do {
//                let covidData = try JSONDecoder().decode(CovidData.self, from: data)
//
//                // создаем массив объектов для сохранения
//                var covidDataObject: [CovidDataInCurrentTime] = []
//
//                guard let responces = covidData.response else { return }
//
//                for responce in responces {
//
//                    let new = responce.cases?.new?.customizeNew() ?? 0
//                    let active = responce.cases?.active ?? 0
//                    let critical = responce.cases?.critical ?? 0
//                    let recovered = responce.cases?.recovered ?? 0
//                    let affected = responce.cases?.total ?? 0
//                    let death = responce.deaths?.total ?? 0
//                    let country = responce.country ?? "No country"
//
//                    let data = CovidDataInCurrentTime(
//                        new: new,
//                        active: active,
//                        critical: critical,
//                        recovered: recovered,
//                        affected: affected,
//                        death: death,
//                        country: country)
//
//                    covidDataObject.append(data)
//                }
//
//                //сохраняем в память
//                do {
//                    let data = try JSONEncoder().encode(covidDataObject)
//
//                        UserDefaults.standard.set(data, forKey: "covidData")
//                        print("глобальные данные за сегодня сохранены по ключу: covidData")
//                    }
//                } catch {
//                    print(error)
//                }
//
//        }
//    }
//}
