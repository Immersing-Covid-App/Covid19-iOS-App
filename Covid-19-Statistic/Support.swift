//
//  Support.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 07.10.2021.
//

import UIKit
import Charts

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            self.addSubview(subview)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            self.addArrangedSubview(subview)
        }
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

// преобразование данных new
extension String {
    func customizeNew() -> Int {
        let newString = self.dropFirst()
        return Int(newString) ?? 0
    }
}


