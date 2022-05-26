//
//  SceneDelegate.swift
//  Covid-19-Statistic
//
//  Created by Dmitrii Lobanov on 04.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        // чистим UserDefaults
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()

        let mainVC = MainVC()
        let statVC = StatVC()
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        mainVC.tabBarItem.title = "Main"
        statVC.tabBarItem.image = UIImage(systemName: "square.grid.3x2")
        statVC.tabBarItem.title = "Statistic"

        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [mainVC, statVC]

        tabBarVC.tabBar.tintColor = UIColor(named: "mainViewColor")
        tabBarVC.tabBar.unselectedItemTintColor = .systemGray4

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
