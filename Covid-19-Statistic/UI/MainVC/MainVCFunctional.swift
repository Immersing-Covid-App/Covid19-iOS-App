//
//  MainVCFunctional.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 11.10.2021.
//

import UIKit

let number: String = "88007008000"

extension MainVC {


// метод звонка
    @objc func call() {
        print(11)
            let url = URL(string: "tel://\(number)")!
        UIApplication.shared.open(url)
    }
    }

// метод смс


