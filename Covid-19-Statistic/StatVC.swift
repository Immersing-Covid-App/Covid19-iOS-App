//
//  StatVC.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 08.10.2021.
//

import UIKit

class StatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }

    private lazy var hamburgerMenu: UIView = {
        let hamburgerMenu = UIView()
        return hamburgerMenu
    }()

    private lazy var hamburgerFirst: UIView = {
        let hamburgerFirst = UIView()
        hamburgerFirst.backgroundColor = .white
        hamburgerFirst.layer.cornerRadius = 1.25
        hamburgerFirst.clipsToBounds = true
        return hamburgerFirst
    }()

    private lazy var hamburgerSecond: UIView = {
        let hamburgerSecond = UIView()
        hamburgerSecond.backgroundColor = .white
        hamburgerSecond.layer.cornerRadius = 1.25
        hamburgerSecond.clipsToBounds = true
        return hamburgerSecond
    }()

    private lazy var bell: UIImageView = {
        let bell = UIImageView()
        bell.image = UIImage(named: "bell")
        return bell
    }()


    private func viewSetup() {
        view.backgroundColor = UIColor(named: "mainViewColor")
        view.addSubviews(hamburgerMenu, bell)

        hamburgerMenu.addSubviews(hamburgerFirst, hamburgerSecond)


        // Constraints

        hamburgerMenu.height(18)
        hamburgerMenu.width(24)
        hamburgerMenu.leftToSuperview(offset: 24)
        hamburgerMenu.topToSuperview(offset: 51)

        hamburgerFirst.width(18)
        hamburgerFirst.height(2.5)
        hamburgerFirst.topToSuperview(offset: 3.75)
        hamburgerFirst.leftToSuperview(offset: 3)
        hamburgerSecond.width(12)
        hamburgerSecond.height(2.5)
        hamburgerSecond.bottomToSuperview(offset: -3.75)
        hamburgerSecond.leftToSuperview(offset: 3)

        bell.rightToSuperview(offset: -27)
        bell.topToSuperview(offset: 50)
        bell.height(24)
        bell.width(24)


    }



}
