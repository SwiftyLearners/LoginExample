//
//  TabBarController.swift
//  ScrollView
//
//  Created by Aleksei Permiakov on 12.05.2023.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let customFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        let normalTextAttributes = [NSAttributedString.Key.font: customFont,
                                    NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        let selectedTextAttributes = [NSAttributedString.Key.font: customFont,
                                      NSAttributedString.Key.foregroundColor: UIColor.systemTeal]

        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = normalTextAttributes
        tabBarItemAppearance.selected.titleTextAttributes = selectedTextAttributes
        tabBarItemAppearance.normal.iconColor = .systemGray
        tabBarItemAppearance.selected.iconColor = .systemTeal

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.configureWithDefaultBackground()

        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.standardAppearance = tabBarAppearance
    }
    
    func setupVCs() {
        let loginVC = LoginViewController()
        let settingsVC = SettingsViewController()
        
        viewControllers = [
            createNavController(for: loginVC,
                                title: NSLocalizedString("Home", comment: ""),
                                image: UIImage(systemName: "house")),
            createNavController(for: settingsVC,
                                title: NSLocalizedString("Settings", comment: ""),
                                image: UIImage(systemName: "gearshape")),
            createNavController(for: UIViewController(),
                                title: "Some",
                                image: UIImage(systemName: "heart"))
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage?) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
