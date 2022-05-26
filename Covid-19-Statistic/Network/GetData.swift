//
//  GetCurrentData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 29.10.2021.
//

import Foundation

extension NetworkManager {
    
    // метод получения и сохранения данных
    func getTodayDataForCurrentCountry(country: String, date: Date) {
        
        // переменная для хранения данных текущей страны
        var resultCountry: [ResultCountry] = []
        
        let dateStr = date.toString()
        
        // проверяем URL
        guard let url = NSURL(string: url + "\(country)/" + dateStr) else { print("url invalid"); return }
        
        // создаем сессию
        let session = URLSession.shared
        
        // создаем задачу запроса
        let task = URLRequest(url: url as URL)
        
        // инициализируем задачу
        session.dataTask(with: task) { data, responce, error in
            
            // проверяем, что пришел ответ
            guard responce != nil else {
                DispatchQueue.main.async {
                    MainVC().postError()
                }
                return
            }
            
            
            // проверяем, что пришла data
            guard let data = data else { print("data не пришла"); return }
            // декодируем JSON
            
            do {
                resultCountry = try JSONDecoder().decode([ResultCountry].self, from: data)
                
                // сохраняем
                UserDefaults.standard.set(try JSONEncoder().encode(resultCountry), forKey: "\(country)-\(dateStr)")
                UserDefaults.standard.synchronize()
                
            } catch {}
        }.resume()
    }
}
