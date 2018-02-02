//
//  AppDelegate.swift
//  TwitterBird
//
//  Created by Teaocat on 2018/2/2.
//  Copyright © 2018年 learning-swift. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mask: CALayer?
    var imageView: UIImageView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            // add background imageView
            imageView = UIImageView(frame: window.bounds)
            imageView?.image = UIImage(named: "twitterScreen");
            window.addSubview(imageView!)
            
            // make window visible
            window.rootViewController = UIViewController()
            window.backgroundColor = UIColor(red: 70/255, green: 154/255, blue: 233/255, alpha: 1)
            window.makeKeyAndVisible()
        }
        // hide the status bar
        UIApplication.shared.isStatusBarHidden = true
        return true
    }
    
    func animateMask() {
        
    }

}

