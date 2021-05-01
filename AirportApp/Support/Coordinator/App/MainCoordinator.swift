//
//  MainCoordinator.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit

final class MainCoordinator: MainBaseCoordinator {
    
    var settingsCoordinator: SettingsBaseCoordinator?
    
    var airportsCoordinator: AirportsBaseCoordinator?
    
    var flightsCoordinator: FlightsBaseCoordinator?
    
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        airportsCoordinator = AirportsCoordinator()
        flightsCoordinator = FlightsCoordinator()
        settingsCoordinator = SettingsCoordinator()
        guard let airportsCoordinator = airportsCoordinator,
              let flightsCoordinator = flightsCoordinator,
              let settingsCoordinator = settingsCoordinator else { fatalError() }
        
        let tabBarController = UITabBarController()
        rootViewController = tabBarController
                
        let airportsViewController = airportsCoordinator.start()
        airportsViewController.tabBarItem = UITabBarItem(title: ContextStrings.TabBar.airportsTabTitle, image: UIImage(systemName: "airplane"), tag: 0)
        
        let flightsViewController = flightsCoordinator.start()
        flightsViewController.tabBarItem = UITabBarItem(title: ContextStrings.TabBar.flightsTabTitle, image: UIImage(systemName: "list.bullet.rectangle"), tag: 1)
        
        let settingsViewController = settingsCoordinator.start()
        settingsViewController.tabBarItem = UITabBarItem(title: ContextStrings.TabBar.settingsTabTitle, image: UIImage(systemName: "gearshape"), tag: 2)
        
        tabBarController.viewControllers = [airportsViewController, flightsViewController, settingsViewController]
        
        return tabBarController
    }
}
