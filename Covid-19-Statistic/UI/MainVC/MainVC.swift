//
//  MainVC.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 04.10.2021.
//

import UIKit
import TinyConstraints

final class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()

        // получаем и сохраняем все данные
//            let _ = NetworkManager(country: currentCountry, vc: self)
            self.errorData()
    }

    override func viewWillAppear(_ animated: Bool) {
        UITabBar.appearance().barTintColor = .white
        let _ = NetworkManager(country: currentCountry, vc: self)
    }

    // MARK: - UI elements

    private lazy var mainScrollView: UIScrollView = {
        let mainScrollView = UIScrollView()
        mainScrollView.backgroundColor = .white
        mainScrollView.delegate = self
        return mainScrollView
    }()

    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = UIColor(named: "mainViewColor")
        mainView.layer.cornerRadius = 40
        mainView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        mainView.clipsToBounds = true
        return mainView
    }()

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

    private lazy var mainTitle: UILabel = {
        let mainTitle = UILabel()
        mainTitle.text = "Covid-19"
        mainTitle.font = UIFont(name: "Graphik-Semibold", size: 24)
        mainTitle.textColor = .white
        return mainTitle
    }()

    private lazy var countrySelectView: UIView = {
        let countrySelectView = UIView()
        countrySelectView.backgroundColor = .white
        countrySelectView.layer.cornerRadius = 20
        countrySelectView.clipsToBounds = true
        return countrySelectView
    }()

    private lazy var countryFlag: UIImageView = {
        let countryFlag = UIImageView()
        countryFlag.image = UIImage(named: "usaFlag")
        countryFlag.layer.cornerRadius = 12
        countryFlag.clipsToBounds = true
        return countryFlag
    }()

    private lazy var countryName: UILabel = {
        let countryName = UILabel()
        countryName.text = "USA"
        countryName.font = UIFont(name: "Graphik-Medium", size: 14)
        countryName.textColor = .black
        return countryName
    }()

    private lazy var countrySelectTriangle: UIImageView = {
        let countrySelectTriangle = UIImageView()
        countrySelectTriangle.image = UIImage(named: "countrySelectTriangle")
        return countrySelectTriangle
    }()

    private lazy var mainText: UILabel = {
        let mainText = UILabel()
        mainText.text = "Are you feeling sick?"
        mainText.font = UIFont(name: "Graphik-Semibold", size: 20)
        mainText.textColor = .white
        return mainText
    }()

    private lazy var mainText2: UILabel = {
        let mainText2 = UILabel()
        mainText2.font = UIFont(name: "Graphik-Regular", size: 14)
        mainText2.textColor = .white
        mainText2.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.43
        mainText2.attributedText = NSMutableAttributedString(string: "If you feel sick with any of covid-19 symptoms please call or SMS us immediately for help.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return mainText2
    }()

    private lazy var callButtonView: UIView = {
        let callButtonView = UIView()
        callButtonView.backgroundColor = UIColor(named: "callButtonColor")
        callButtonView.layer.cornerRadius = 24
        callButtonView.clipsToBounds = true
        let gestureCall = UITapGestureRecognizer(target: self, action: #selector(call))
        callButtonView.addGestureRecognizer(gestureCall)
        return callButtonView
    }()


    private lazy var smsButtonView: UIView = {
        let smsButtonView = UIView()
        smsButtonView.backgroundColor = UIColor(named: "smsButtonColor")
        smsButtonView.layer.cornerRadius = 24
        smsButtonView.clipsToBounds = true
        return smsButtonView
    }()

    private lazy var callImage: UIImageView = {
        let callImage = UIImageView()
        callImage.image = UIImage(named: "call")
        return callImage
    }()

    private lazy var smsImage: UIImageView = {
        let smsImage = UIImageView()
        smsImage.image = UIImage(named: "sms")
        return smsImage
    }()

    private lazy var callText: UILabel = {
        let callText = UILabel()
        callText.text = "Call Now"
        callText.font = UIFont(name: "Graphik-Medium", size: 16)
        callText.textColor = .white
        return callText
    }()

    private lazy var smsText: UILabel = {
        let smsText = UILabel()
        smsText.text = "Send SMS"
        smsText.font = UIFont(name: "Graphik-Medium", size: 16)
        smsText.textColor = .white
        return smsText
    }()

    private lazy var preventionImage1: UIImageView = {
        let preventionImage1 = UIImageView()
        preventionImage1.image = UIImage(named: "preventionImage1")
        return preventionImage1
    }()

    private lazy var preventionImage2: UIImageView = {
        let preventionImage2 = UIImageView()
        preventionImage2.image = UIImage(named: "preventionImage2")
        return preventionImage2
    }()

    private lazy var preventionImage3: UIImageView = {
        let preventionImage3 = UIImageView()
        preventionImage3.image = UIImage(named: "preventionImage3")
        return preventionImage3
    }()

    private lazy var preventionText1: UILabel = {
        let preventionText1 = UILabel()
        preventionText1.font = UIFont(name: "Graphik-Medium", size: 14)
        preventionText1.textColor = UIColor(named: "mainViewColor")
        preventionText1.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.17
        preventionText1.attributedText = NSMutableAttributedString(string: "Avoid close contact", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        preventionText1.textAlignment = .center
        return preventionText1
    }()

    private lazy var preventionText2: UILabel = {
        let preventionText2 = UILabel()
        preventionText2.font = UIFont(name: "Graphik-Medium", size: 14)
        preventionText2.textColor = UIColor(named: "mainViewColor")
        preventionText2.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.17
        preventionText2.attributedText = NSMutableAttributedString(string: "Clean your hands often", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        preventionText2.textAlignment = .center
        return preventionText2
    }()

    private lazy var preventionText3: UILabel = {
        let preventionText3 = UILabel()
        preventionText3.font = UIFont(name: "Graphik-Medium", size: 14)
        preventionText3.textColor = UIColor(named: "mainViewColor")
        preventionText3.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.17
        preventionText3.attributedText = NSMutableAttributedString(string: "Wear a facemask", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        preventionText3.textAlignment = .center
        return preventionText3
    }()

    private lazy var preventionView1: UIView = {
        let preventionView1 = UIView()
        return preventionView1
    }()

    private lazy var preventionView2: UIView = {
        let preventionView2 = UIView()
        return preventionView2
    }()
    private lazy var preventionView3: UIView = {
        let preventionView3 = UIView()
        return preventionView3
    }()

    private lazy var preventionTitle: UILabel = {
        let preventionTitle = UILabel()
        preventionTitle.text = "Prevention"
        preventionTitle.font = UIFont(name: "Graphik-Medium", size: 20)
        return preventionTitle
    }()

    private lazy var testView: UIView = {
        let testView = UIView()
        testView.layer.cornerRadius = 16
        testView.clipsToBounds = true
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.337, green: 0.329, blue: 0.62, alpha: 1).cgColor,
            UIColor(red: 0.683, green: 0.63, blue: 0.9, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -1.02, b: 0, c: -0.07, d: -9.4, tx: 1.03, ty: 5.2))
        layer0.bounds = testView.bounds.insetBy(dx: -1*view.bounds.size.width, dy: -1*view.bounds.size.height)
        layer0.position = testView.center
        testView.layer.addSublayer(layer0)
        return testView
    }()

    private lazy var testImage: UIImageView = {
        let testImage = UIImageView()
        testImage.image = UIImage(named: "testImage")
        return testImage
    }()

    private lazy var testTitle: UILabel = {
        let testTitle = UILabel()
        testTitle.text = "Do your own test!"
        testTitle.font = UIFont(name: "Graphik-Semibold", size: 18)
        testTitle.textColor = .white
        return testTitle
    }()

    private lazy var testText: UILabel = {
        let testText = UILabel()
        testText.font = UIFont(name: "Graphik-Regular", size: 14)
        testText.textColor = .white
        testText.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.43
        testText.attributedText = NSMutableAttributedString(string: "Follow the instructions to do your own test.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return testText
    }()
}

// MARK: - Actions
extension MainVC {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func viewSetup() {
        view.backgroundColor = UIColor(named: "mainViewColor")

        view.addSubviews(mainScrollView)

        mainScrollView.addSubviews(mainView, preventionTitle, preventionView1, preventionView2, preventionView3, testView, testImage)

        mainView.addSubviews(hamburgerMenu, bell, mainTitle, countrySelectView, mainText, mainText2, callButtonView, smsButtonView)

        hamburgerMenu.addSubviews(hamburgerFirst, hamburgerSecond)

        countrySelectView.addSubviews(countryFlag, countryName, countrySelectTriangle)

        callButtonView.addSubviews(callImage, callText)

        smsButtonView.addSubviews(smsImage, smsText)

        preventionView1.addSubviews(preventionImage1, preventionText1)

        preventionView2.addSubviews(preventionImage2, preventionText2)

        preventionView3.addSubviews(preventionImage3, preventionText3)

        testView.addSubviews(testTitle, testText)

        // MARK: - Constraints

        // Main View
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.edgesToSuperview(excluding: .top)

        mainView.topToSuperview()

        mainView.widthToSuperview()
        mainView.height(316)

        hamburgerMenu.height(18)
        hamburgerMenu.width(24)
        hamburgerMenu.leftToSuperview(offset: 24)
        hamburgerMenu.topToSuperview(offset: 24)

        hamburgerFirst.width(18)
        hamburgerFirst.height(2.5)
        hamburgerFirst.topToSuperview(offset: 3.75)
        hamburgerFirst.leftToSuperview(offset: 3)
        hamburgerSecond.width(12)
        hamburgerSecond.height(2.5)
        hamburgerSecond.bottomToSuperview(offset: -3.75)
        hamburgerSecond.leftToSuperview(offset: 3)

        bell.rightToSuperview(offset: -27)
        bell.topToSuperview(offset: 23)
        bell.height(24)
        bell.width(24)

        mainTitle.topToBottom(of: hamburgerMenu, offset: 42)
        mainTitle.leftToSuperview(offset: 24)

        countrySelectView.width(116)
        countrySelectView.height(40)
        countrySelectView.centerY(to: mainTitle)
        countrySelectView.rightToSuperview(offset: -31)

        countryFlag.height(24)
        countryFlag.width(24)
        countryFlag.topToSuperview(offset: 8)
        countryFlag.leftToSuperview(offset: 8)

        countryName.centerInSuperview()

        countrySelectTriangle.height(8)
        countrySelectTriangle.width(10.68)
        countrySelectTriangle.topToSuperview(offset: 16)
        countrySelectTriangle.rightToSuperview(offset: -16.33)

        mainText.topToBottom(of: mainTitle, offset: 47)
        mainText.leftToSuperview(offset: 24)

        mainText2.leftToSuperview(offset: 24)
        mainText2.topToBottom(of: mainText, offset: 12)
        mainText2.rightToSuperview(offset: -24)

        callButtonView.width(155)
        callButtonView.height(48)
        callButtonView.topToBottom(of: mainText2, offset: 16)
        callButtonView.leftToSuperview(offset: 24)

        smsButtonView.width(155)
        smsButtonView.height(48)
        smsButtonView.topToBottom(of: mainText2, offset: 16)
        smsButtonView.rightToSuperview(offset: -24)

        callImage.height(24)
        callImage.width(24)
        callImage.topToSuperview(offset: 12)
        callImage.leftToSuperview(offset: 26)

        smsImage.height(24)
        smsImage.width(24)
        smsImage.topToSuperview(offset: 12)
        smsImage.leftToSuperview(offset: 26)

        callText.centerYToSuperview()
        callText.rightToSuperview(offset: -25)

        smsText.centerYToSuperview()
        smsText.rightToSuperview(offset: -20)

        // Prevention View
        preventionTitle.topToBottom(of: mainView, offset: 32)
        preventionTitle.leftToSuperview(offset:24)

        preventionImage1.height(90)
        preventionImage1.width(90)

        preventionImage2.height(90)
        preventionImage2.width(90)

        preventionImage3.height(90)
        preventionImage3.width(90)

        preventionView1.height(138)
        preventionView1.width(90)
        preventionView1.topToBottom(of: preventionTitle, offset: 24)
        preventionView1.leftToSuperview(offset: 24)

        preventionView2.height(138)
        preventionView2.width(90)
        preventionView2.topToBottom(of: preventionTitle, offset: 24)
        preventionView2.centerXToSuperview()

        preventionView3.height(138)
        preventionView3.width(90)
        preventionView3.topToBottom(of: preventionTitle, offset: 24)
        preventionView3.rightToSuperview(offset: -24)

        preventionImage1.topToSuperview()
        preventionImage1.centerXToSuperview()

        preventionImage2.topToSuperview()
        preventionImage2.centerXToSuperview()

        preventionImage3.topToSuperview()
        preventionImage3.centerXToSuperview()

        preventionText1.topToBottom(of: preventionImage1, offset: 12)
        preventionText1.widthToSuperview()

        preventionText2.topToBottom(of: preventionImage2, offset: 12)
        preventionText2.widthToSuperview()

        preventionText3.topToBottom(of: preventionImage1, offset: 12)
        preventionText3.widthToSuperview()

        // Test view
        testView.height(104)
        testView.topToBottom(of: preventionView1,offset: 44)
        testView.leftToSuperview(offset: 24)
        testView.rightToSuperview(offset: -24)
        testView.left(to: view, offset: 24)
        testView.right(to: view, offset: -24)
        testView.bottomToSuperview(offset: -24)

        testImage.height(116)
        testImage.width(111)
        testImage.bottom(to: testView)
        testImage.left(to: testView, offset: 8)

        testTitle.topToSuperview(offset: 16)
        testTitle.rightToSuperview(offset: -39)

        testText.topToBottom(of: testTitle, offset: 8)
        testText.rightToSuperview(offset: -14)
        testText.leftToSuperview(offset: 136)
    }
}

// Dissable up scroll
extension MainVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}


