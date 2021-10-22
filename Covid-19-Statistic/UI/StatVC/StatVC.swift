//
//  StatVC.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 08.10.2021.
//

import UIKit
import TinyConstraints
import Charts

class StatVC: UIViewController {
    
    private var isGlobal: Bool = true
    private var isToday: Bool = false
    private var isYesterday: Bool = false
    private var isTotal: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITabBar.appearance().barTintColor = .white
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            let tabBar = tabBarController?.tabBar
            tabBar!.standardAppearance = appearance
            tabBar!.scrollEdgeAppearance = tabBar!.standardAppearance
            
            setTodayData()

        }
        
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
        mainTitle.text = "Statistic"
        mainTitle.font = UIFont(name: "Graphik-Medium", size: 20)
        mainTitle.textColor = .white
        return mainTitle
    }()
    
    private lazy var switchView: UIView = {
        let switchView = UIView()
        switchView.backgroundColor = UIColor(named: "switchColor")
        switchView.layer.cornerRadius = 24
        switchView.clipsToBounds = true
        return switchView
    }()
    
    private lazy var myCountryLabel: UILabel = {
        let myCountryLabel = UILabel()
        myCountryLabel.text = "My country"
        myCountryLabel.font = UIFont(name: "Graphik-Medium", size: 14)
        myCountryLabel.textColor = UIColor(named: "mainViewColor")
        return myCountryLabel
    }()
    
    private lazy var globalLabel: UILabel = {
        let globalLabel = UILabel()
        globalLabel.text = "Global"
        globalLabel.font = UIFont(name: "Graphik-Medium", size: 14)
        globalLabel.textColor = .white
        return globalLabel
    }()
    
    private lazy var currentSwitchView: UIView = {
        let currentSwitchView = UIView()
        currentSwitchView.backgroundColor = .white
        currentSwitchView.layer.cornerRadius = 20
        currentSwitchView.clipsToBounds = true
        return currentSwitchView
    }()
    
    private lazy var myCountrySwitchButton: UIButton = {
        let myCountrySwitchButton = UIButton()
        myCountrySwitchButton.layer.cornerRadius = 20
        myCountrySwitchButton.clipsToBounds = true
        myCountrySwitchButton.addTarget(self, action: #selector(myCountryTap), for: .touchUpInside)
        return myCountrySwitchButton
    }()
    
    private lazy var globalSwitchButton: UIButton = {
        let globalSwitchButton = UIButton()
        globalSwitchButton.layer.cornerRadius = 20
        globalSwitchButton.clipsToBounds = true
        globalSwitchButton.addTarget(self, action: #selector(globalTap), for: .touchUpInside)
        return globalSwitchButton
    }()
    
    private lazy var totalButton: UIButton = {
        let totalButton = UIButton()
        totalButton.setTitle("Total", for: .normal)
        totalButton.titleLabel?.font =  UIFont(name: "Graphik-Semibold", size: 14)
        totalButton.setTitleColor(.white, for: .normal)
        totalButton.addTarget(self, action: #selector(totalButtonTap), for: .touchUpInside)
        
        return totalButton
    }()
    
    private lazy var todayButton: UIButton = {
        let todayButton = UIButton()
        todayButton.setTitle("Today", for: .normal)
        todayButton.titleLabel?.font =  UIFont(name: "Graphik-Semibold", size: 14)
        todayButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        todayButton.addTarget(self, action: #selector(todayButtonTap), for: .touchUpInside)
        return todayButton
    }()
    
    private lazy var yesterdayButton: UIButton = {
        let yesterdayButton = UIButton()
        yesterdayButton.setTitle("Yesterday", for: .normal)
        yesterdayButton.titleLabel?.font =  UIFont(name: "Graphik-Semibold", size: 14)
        yesterdayButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        yesterdayButton.addTarget(self, action: #selector(yesterdayButtonTap), for: .touchUpInside)
        return yesterdayButton
    }()
    
    @objc func totalButtonTap() {
        isToday = false
        isYesterday = false
        isTotal = true
        todayButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        yesterdayButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        totalButton.setTitleColor(.white, for: .normal)
    }
    
    private lazy var dayStackView: UIStackView = {
        let dayStackView = UIStackView()
        dayStackView.axis = .horizontal
        dayStackView.spacing = 23
        dayStackView.distribution = .equalSpacing
        return dayStackView
    }()
    
    private lazy var affectedView: UIView = {
        let affectedView = UIView()
        affectedView.backgroundColor = UIColor(named: "affectedColor")
        affectedView.layer.cornerRadius = 8
        return affectedView
    }()
    
    private lazy var deathView: UIView = {
        let deathView = UIView()
        deathView.backgroundColor = UIColor(named: "deathColor")
        deathView.layer.cornerRadius = 8
        return deathView
    }()
    
    private lazy var affectedAndDeathStackView: UIStackView = {
        let affectedAndDeathStackView = UIStackView()
        affectedAndDeathStackView.axis = .horizontal
        affectedAndDeathStackView.spacing = 16
        affectedAndDeathStackView.distribution = .fillEqually
        return affectedAndDeathStackView
    }()
    
    private lazy var affectedTitle: UILabel = {
        let affectedTitle = UILabel()
        affectedTitle.text = "Affected"
        affectedTitle.font = UIFont(name: "Graphik-Medium", size: 14)
        affectedTitle.textColor = .white
        return affectedTitle
    }()
    
    lazy var affectedNumbers: UILabel = {
        let affectedNumbers = UILabel()
        affectedNumbers.text = "336 998"
        affectedNumbers.font = UIFont(name: "Graphik-Semibold", size: 24)
        affectedNumbers.textColor = .white
        return affectedNumbers
    }()
    
    private lazy var deathTitle: UILabel = {
        let affectedTitle = UILabel()
        affectedTitle.text = "Death"
        affectedTitle.font = UIFont(name: "Graphik-Medium", size: 14)
        affectedTitle.textColor = .white
        return affectedTitle
    }()
    
    lazy var deathNumbers: UILabel = {
        let deathNumbers = UILabel()
        deathNumbers.text = "9 800"
        deathNumbers.font = UIFont(name: "Graphik-Semibold", size: 24)
        deathNumbers.textColor = .white
        return deathNumbers
    }()
    
    private lazy var recoveredView: UIView = {
        let recoveredView = UIView()
        recoveredView.backgroundColor = UIColor(named: "recoveredColor")
        recoveredView.layer.cornerRadius = 8
        return recoveredView
    }()
    
    private lazy var activeView: UIView = {
        let activeView = UIView()
        activeView.backgroundColor = UIColor(named: "activeColor")
        activeView.layer.cornerRadius = 8
        return activeView
    }()
    
    private lazy var seriousView: UIView = {
        let seriousView = UIView()
        seriousView.backgroundColor = UIColor(named: "seriousColor")
        seriousView.layer.cornerRadius = 8
        return seriousView
    }()
    
    private lazy var recoveredAndActiveAndSeriousStackView: UIStackView = {
        let recoveredAndActiveAndSeriousStackView = UIStackView()
        recoveredAndActiveAndSeriousStackView.axis = .horizontal
        recoveredAndActiveAndSeriousStackView.spacing = 16
        recoveredAndActiveAndSeriousStackView.distribution = .fillEqually
        return recoveredAndActiveAndSeriousStackView
    }()
    
    private lazy var recoveredTitle: UILabel = {
        let recoveredTitle = UILabel()
        recoveredTitle.text = "Recovered"
        recoveredTitle.font = UIFont(name: "Graphik-Medium", size: 14)
        recoveredTitle.textColor = .white
        return recoveredTitle
    }()
    
    lazy var recoveredNumbers: UILabel = {
        let recoveredNumbers = UILabel()
        recoveredNumbers.text = "Null"
        recoveredNumbers.font = UIFont(name: "Graphik-Semibold", size: 12)
        recoveredNumbers.textColor = .white
        return recoveredNumbers
    }()
    
    private lazy var activeTitle: UILabel = {
        let activeTitle = UILabel()
        activeTitle.text = "Active"
        activeTitle.font = UIFont(name: "Graphik-Medium", size: 14)
        activeTitle.textColor = .white
        return activeTitle
    }()
    
    lazy var activeNumbers: UILabel = {
        let activeNumbers = UILabel()
        activeNumbers.text = "9 800"
        activeNumbers.font = UIFont(name: "Graphik-Semibold", size: 12)
        activeNumbers.textColor = .white
        return activeNumbers
    }()
    
    private lazy var seriousTitle: UILabel = {
        let seriousTitle = UILabel()
        seriousTitle.text = "Serious"
        seriousTitle.font = UIFont(name: "Graphik-Medium", size: 14)
        seriousTitle.textColor = .white
        return seriousTitle
    }()
    
    lazy var seriousNumbers: UILabel = {
        let seriousNumbers = UILabel()
        seriousNumbers.text = "9 800"
        seriousNumbers.font = UIFont(name: "Graphik-Semibold", size: 12)
        seriousNumbers.textColor = .white
        return seriousNumbers
    }()
    
    private lazy var chartView: UIView = {
        let chartView = UIView()
        chartView.backgroundColor = .white
        chartView.layer.cornerRadius = 40
        chartView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        chartView.clipsToBounds = true
        return chartView
    }()
    
    private lazy var chartTitle: UILabel = {
        let chartTitle = UILabel()
        chartTitle.text = "Daily New Cases"
        chartTitle.font = UIFont(name: "Graphik-Medium", size: 20)
        chartTitle.textColor = UIColor(named: "mainViewColor")
        return chartTitle
    }()
    
    private lazy var barChart: BarChartView = {
        let barChart = BarChartView()
        barChart.legend.enabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.highlightPerTapEnabled = false
        barChart.highlightPerDragEnabled = false
        barChart.rightAxis.enabled = false
        barChart.animate(yAxisDuration: 2)
        // левая шкала
        let leftAxis = barChart.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.axisLineWidth = 0
        leftAxis.gridLineDashLengths = [4]
        leftAxis.gridColor = UIColor(named: "gridColor")!
        leftAxis.labelFont = UIFont(name: "Graphik-Regular", size: 10)!
        leftAxis.labelTextColor = UIColor(named: "axisColor")!
        leftAxis.valueFormatter = CustomLeftAxisValueFormatter()
        // нижняя шкала
        let xAxis = barChart.xAxis
        xAxis.labelPosition = .bottom
        xAxis.gridColor = .clear
        xAxis.gridLineWidth = 1.5
        xAxis.axisLineWidth = 0
        xAxis.drawGridLinesEnabled = false
        xAxis.labelFont = UIFont(name: "Graphik-Regular", size: 10)!
        xAxis.labelTextColor = UIColor(named: "axisColor")!
        xAxis.valueFormatter = CustomXAxisValueFormatter()
        return barChart
    }()
    
    func chartCreate(entry: [BarChartDataEntry]) {
        let dataSet = BarChartDataSet(entries: entry)
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.2
        dataSet.colors = [UIColor(named: "barColor")!]
        dataSet.valueColors = [NSUIColor(cgColor: UIColor(named: "mainViewColor")!.cgColor)]
        barChart.data = data
    }
}

// MARK: - Actions
extension StatVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func viewSetup() {
        view.backgroundColor = UIColor(named: "mainViewColor")
        mainScrollView.backgroundColor = UIColor(named: "mainViewColor")
        
        view.addSubviews(mainScrollView)
        
        mainView.addSubviews(hamburgerMenu, bell, mainTitle)
        
        hamburgerMenu.addSubviews(hamburgerFirst, hamburgerSecond)
        
        switchView.addSubviews(currentSwitchView, myCountryLabel, globalLabel, myCountrySwitchButton, globalSwitchButton)
        
        mainScrollView.addSubviews(mainView, switchView, dayStackView, affectedAndDeathStackView, recoveredAndActiveAndSeriousStackView, chartView)
        
        dayStackView.addArrangedSubviews(totalButton, todayButton, yesterdayButton)
        
        affectedAndDeathStackView.addArrangedSubviews(affectedView, deathView)
        
        recoveredAndActiveAndSeriousStackView.addArrangedSubviews(recoveredView, activeView, seriousView)
        
        affectedView.addSubviews(affectedTitle, affectedNumbers)
        
        deathView.addSubviews(deathTitle, deathNumbers)
        
        recoveredView.addSubviews(recoveredTitle, recoveredNumbers)
        
        activeView.addSubviews(activeTitle, activeNumbers)
        
        seriousView.addSubviews(seriousTitle, seriousNumbers)
        
        chartView.addSubviews(chartTitle, barChart)
        
        // MARK: - Constraints
        
        // Main View
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
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
        
        // SwitchView
        switchView.topToBottom(of: mainTitle, offset: 24)
        switchView.leftToSuperview(offset: 24)
        switchView.rightToSuperview(offset: -24)
        switchView.height(48)
        switchView.widthToSuperview(offset: -48)
        
        myCountryLabel.centerYToSuperview()
        myCountryLabel.leftToSuperview(offset: 41)
        
        globalLabel.centerYToSuperview()
        globalLabel.rightToSuperview(offset: -61)
        
        myCountrySwitchButton.leftToSuperview(offset: 4)
        myCountrySwitchButton.centerYToSuperview()
        myCountrySwitchButton.height(40)
        myCountrySwitchButton.width(160)
        
        globalSwitchButton.rightToSuperview(offset: -4)
        globalSwitchButton.centerYToSuperview()
        globalSwitchButton.height(40)
        globalSwitchButton.width(160)
        
        currentSwitchView.centerYToSuperview()
        if isGlobal {
            currentSwitchView.leftToSuperview(offset: 4)
        } else {
            currentSwitchView.rightToSuperview(offset: -4)
        }
        currentSwitchView.height(40)
        currentSwitchView.width(160)
        
        dayStackView.centerXToSuperview()
        dayStackView.topToBottom(of: switchView, offset: 24)
        
        affectedAndDeathStackView.height(100)
        affectedAndDeathStackView.leftToSuperview(offset: 24)
        affectedAndDeathStackView.rightToSuperview(offset: -24)
        affectedAndDeathStackView.topToBottom(of: dayStackView, offset: 24)
        
        affectedView.heightToSuperview()
        
        deathView.heightToSuperview()
        
        affectedTitle.topToSuperview(offset: 16)
        affectedTitle.leftToSuperview(offset: 12)
        
        affectedNumbers.bottomToSuperview(offset: -10)
        affectedNumbers.leftToSuperview(offset: 12)
        
        deathTitle.topToSuperview(offset: 16)
        deathTitle.leftToSuperview(offset: 12)
        
        deathNumbers.bottomToSuperview(offset: -10)
        deathNumbers.leftToSuperview(offset: 12)
        
        recoveredAndActiveAndSeriousStackView.height(100)
        recoveredAndActiveAndSeriousStackView.leftToSuperview(offset: 24)
        recoveredAndActiveAndSeriousStackView.rightToSuperview(offset: -24)
        recoveredAndActiveAndSeriousStackView.topToBottom(of: affectedAndDeathStackView, offset: 16)
        
        recoveredView.heightToSuperview()
        
        activeView.heightToSuperview()
        
        seriousView.heightToSuperview()
        
        recoveredTitle.topToSuperview(offset: 16)
        recoveredTitle.leftToSuperview(offset: 12)
        
        recoveredNumbers.bottomToSuperview(offset: -10)
        recoveredNumbers.leftToSuperview(offset: 12)
        recoveredNumbers.rightToSuperview(offset: -12)
        
        activeTitle.topToSuperview(offset: 16)
        activeTitle.leftToSuperview(offset: 12)
        
        activeNumbers.bottomToSuperview(offset: -10)
        activeNumbers.leftToSuperview(offset: 12)
        activeNumbers.rightToSuperview(offset: -12)
        
        seriousTitle.topToSuperview(offset: 16)
        seriousTitle.leftToSuperview(offset: 12)
        
        seriousNumbers.bottomToSuperview(offset: -10)
        seriousNumbers.leftToSuperview(offset: 12)
        seriousNumbers.rightToSuperview(offset: -12)
        
        chartView.topToBottom(of: recoveredAndActiveAndSeriousStackView, offset: 24)
        chartView.leftToSuperview()
        chartView.rightToSuperview()
        chartView.bottomToSuperview()
        chartView.height(285)
        
        chartTitle.topToSuperview(offset: 39)
        chartTitle.leftToSuperview(offset: 24)
        
        barChart.topToBottom(of: chartTitle, offset: 24)
        barChart.leftToSuperview(offset: 40)
        barChart.rightToSuperview(offset: -40)
        barChart.bottomToSuperview(offset: -40)
    }
}

// Dissable up scroll
extension StatVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.tabBarController?.tabBar.backgroundColor = .white
        }, completion: nil)
    }
}

// Switch actions
extension StatVC {
    @objc func myCountryTap() {
        let goToLeft = CABasicAnimation(keyPath: "position")
        goToLeft.fromValue = currentSwitchView.layer.position
        goToLeft.toValue = myCountrySwitchButton.layer.position
        goToLeft.duration = 0.1
        currentSwitchView.layer.add(goToLeft, forKey: nil)
        currentSwitchView.layer.position = myCountrySwitchButton.layer.position
        globalLabel.textColor = .white
        myCountryLabel.textColor = UIColor(named: "mainViewColor")
        isGlobal = false
    }
    
    @objc func globalTap() {
        let goToRight = CABasicAnimation(keyPath: "position")
        goToRight.fromValue = currentSwitchView.layer.position
        goToRight.toValue = globalSwitchButton.layer.position
        goToRight.duration = 0.1
        currentSwitchView.layer.add(goToRight, forKey: nil)
        currentSwitchView.layer.position = globalSwitchButton.layer.position
        globalLabel.textColor = UIColor(named: "mainViewColor")
        myCountryLabel.textColor = .white
        isGlobal = true
    }
    
    @objc func todayButtonTap() {
        isToday = true
        isYesterday = false
        isTotal = false
        totalButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        yesterdayButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        todayButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func yesterdayButtonTap() {
        isToday = false
        isYesterday = true
        isTotal = false
        totalButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        todayButton.setTitleColor(UIColor(named: "switchColor"), for: .normal)
        yesterdayButton.setTitleColor(.white, for: .normal)
    }
}
