//
//  CustomBarWithCornerRadius.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 23.10.2021.
//

import Foundation


// найти
/*

if !isSingleColor
{
    // Set the color for the currently drawn value. If the index is out of bounds, reuse colors.
    context.setFillColor(dataSet.color(atIndex: j).cgColor)
}

            context.fill(barRect)



заменить

context.fill(barRect)

на

let bezierPath = UIBezierPath(roundedRect: barRect, cornerRadius: 20)
context.addPath(bezierPath.cgPath)
context.drawPath(using: .fill)

 */
