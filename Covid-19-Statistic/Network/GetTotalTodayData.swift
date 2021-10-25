//
//  GetTotalTodayData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 24.10.2021.
//

import Foundation
import Alamofire

extension NetworkManager {

    // метод получения данных выбранной страны за текущую дату
    func getTotalTodayDataForCurrentCountry(country: String) {

        let currenURL = "https://\(apiHost)/statistics?country=\(country)"

        AF.request(currenURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).responseJSON { (responceData) in

            guard let data = responceData.data else {
                NotificationCenter.default.post(name: Notification.Name("errorGetData"), object: nil)
                return }

            do {
                let covidData = try JSONDecoder().decode(CovidData.self, from: data
                )

                guard let gotData = covidData.response else { return }

                guard let gotDataTotal = gotData[0].cases?.total else { return }
                guard let gotDataActive = gotData[0].cases?.active else { return }
                guard let gotDataCritical = gotData[0].cases?.critical else { return }
                guard let gotDataRecovered = gotData[0].cases?.recovered else { return }
                guard let gotDataDeath = gotData[0].deaths?.total else { return }
                guard let stringDate = gotData[0].time else { return }
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
                guard let date = dateFormatter.date(from: stringDate) else { return }


                guard let gotDataNew = gotData[0].cases?.new else { return }
                let newData = gotDataNew.customizeNew()



                // создаем объект с данными
                let dataTotal = CovidDataInCurrentTime(new: newData, active: gotDataActive, critical: gotDataCritical, recovered: gotDataRecovered, affected: gotDataTotal, death: gotDataDeath, date: date)
                //сохраняем в память


                    let data = try? JSONEncoder().encode(dataTotal)
                        UserDefaults.standard.set(data, forKey: "dataTotal")
            } catch {
                print(error.localizedDescription)
            }

        }

    }


}
