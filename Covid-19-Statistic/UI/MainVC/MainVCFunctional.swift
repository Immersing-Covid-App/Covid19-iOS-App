//
//  MainVCFunctional.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 11.10.2021.
//

import UIKit

let number: String = "122"

extension MainVC {
    
    
    // метод звонка
    @objc func call() {
        let url = URL(string: "tel://\(number)")!
        UIApplication.shared.open(url)
    }
    
    // метод открытия информации о тестах
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: "https://xn--80aesfpebagmfblc0a.xn--p1ai/faq/?tags=39") else { return }
        // Проверка версии IOS
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [ : ] , completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
