//
//  ErrorData.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 25.10.2021.
//

import Foundation
import UIKit

// Notification
// Подписки под уведомления об ошибках и их методы

extension MainVC {

    func errorData() {
        NotificationCenter.default.addObserver(self, selector: #selector(errorGetData), name: Notification.Name("errorGetData"), object: nil)
    }
    
    func postError() {
        NotificationCenter.default.post(name: Notification.Name("errorGetData"), object: nil)
    }

    @objc func errorGetData() {
        let alertVC = UIAlertController(title: "Error", message: "No data received, check your internet connection", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension StatVC {
    func errorData() {
        NotificationCenter.default.addObserver(self, selector: #selector(noDataForToday), name: Notification.Name("noDataForToday"), object: nil)
    }
    
    func postError() {
        NotificationCenter.default.post(name: Notification.Name("noDataForToday"), object: nil)
    }

    @objc func noDataForToday() {
        let alertVC = UIAlertController(title: "No data", message: "try again later", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}
