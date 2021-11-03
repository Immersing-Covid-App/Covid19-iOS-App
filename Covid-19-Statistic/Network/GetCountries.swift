//
//  GetCountries.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 31.10.2021.
//

import Foundation
import Alamofire

extension NetworkManager {

   func getCountries() {
       
        // URL
        let url = "https://\(apiHost)/countries"

        // запрос данных
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).responseJSON { (responceData) in

            // проверяем, получены ли данные
            guard let data = responceData.data else {
                // если нет, вызываем алерт
                NotificationCenter.default.post(name: Notification.Name("errorGetData"), object: nil)
                return }

            // кодируем данные для сохранения
            do {
                let covidData = try JSONDecoder().decode(CountriesData.self, from: data)

                // проверяем, получены ли данные
                guard let countriesList = covidData.response else { return }

                // массив для стран
                var countriesArray: [String] = []

                // добавляем страны в массив
                for country in countriesList {
                    countriesArray.append(country)
                }

                // сохраняем страны в UserDefaults
                UserDefaults.standard.set(countriesArray, forKey: "countries")
                print("Страны получены и сохранены по ключу countries")

                UserDefaults.standard.synchronize()
                
            } catch {
                print(error)
            }
        }
    }
}
