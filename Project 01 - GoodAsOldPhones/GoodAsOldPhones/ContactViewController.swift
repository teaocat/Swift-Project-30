//
//  ContactViewController.swift
//  GoodAsOldPhones
//
//  Created by Teaocat on 2018/1/4.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.top)
        } else {
            scrollView.frame = CGRect(x: 0, y: self.topLayoutGuide.length, width: view.frame.width, height: view.frame.height - self.topLayoutGuide.length)
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
    }

}
