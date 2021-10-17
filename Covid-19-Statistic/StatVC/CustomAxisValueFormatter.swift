//
//  CustomAxisValueFormatter.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 17.10.2021.
//

import Foundation
import Charts

final class MyCustomAxisValueFormatter: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value == 0 {
            return "0"
        } else {
            return "\(Int(value) / 1000)к"
        }
        
    }
    
    
}
