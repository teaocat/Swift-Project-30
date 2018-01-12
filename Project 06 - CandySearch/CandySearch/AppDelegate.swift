//
//  AppDelegate.swift
//  CandySearch
//
//  Created by Teaocat on 2018/1/11.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = window?.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count - 1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
        UISearchBar.appearance().barTintColor = UIColor.candyGreen()
        UISearchBar.appearance().tintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.candyGreen()
        return true
    }
    
    // MARK: - Split view
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryViewController = secondaryViewController as? UINavigationController else { return false }
        guard let toAsDetailViewController = secondaryViewController.topViewController as? DetailViewController else { return false }
        
        if toAsDetailViewController.candy == nil {
            return true
        }
        
        return false
    }
    
}

extension UIColor {
    static func candyGreen() -> UIColor {
        return UIColor(red: 67.0/255.0, green: 205.0/255.0, blue: 135.0/255.0, alpha: 1.0)
    }
}
