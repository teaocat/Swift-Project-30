//
//  Helper.swift
//  LoveTweet
//
//  Created by Teaocat on 2018/1/6.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit
import Social

enum Gender: Int {
    case Male = 0, Famale
}

extension Selector {
    static let endEditing = #selector(UIView.endEditing(_:))
}

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
