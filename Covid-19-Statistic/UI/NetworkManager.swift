//
//  NetworkManager.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 18.10.2021.
//

import Foundation
import Alamofire

let headers = [
    "x-rapidapi-host": apiHost,
    "x-rapidapi-key": apiKey
]

class NetworkManager {


    // метод получения данных выбранной страны за текущую дату
    func getTodayStatisticForCurrentCountry(country: String) {

        let currenURL = "https://\(apiHost)/statistics?country=\(country)"

        AF.request(currenURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).responseJSON { (responceData) in

            guard let data = responceData.data else { return }

            do {
                let covidData = try JSONDecoder().decode(CovidData.self, from: data
                )

//                print(covidData.response![0].cases?.new)
//                print(covidData.response![0].cases?.active)
//                print(covidData.response![0].cases?.critical)
//                print(covidData.response![0].cases?.recovered)
//                let stringDate = covidData.response![0].time
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
//                let date = dateFormatter.date(from: stringDate!)
//                print(date)

                // присваиваем полученные данные переменным
                guard let gotData = covidData.response else { return }
                guard let gotDataTotal = gotData[0].cases?.total else { return}
                affected = gotDataTotal

            } catch {
                print(error.localizedDescription)
            }




            
        }
    }
}
