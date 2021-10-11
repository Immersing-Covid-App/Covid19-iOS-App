//
//  Support.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 07.10.2021.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            self.addSubview(subview)
        }
    }
}

extension UIStackView {
    func addAddArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            self.addArrangedSubview(subview)
        }
    }
}
