//
//  ViewController.swift
//  QuoraDots
//
//  Created by Teaocat on 2018/2/3.
//  Copyright © 2018年 learning-swift. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dotOne: UIImageView!
    @IBOutlet weak var dotTwo: UIImageView!
    @IBOutlet weak var dotThree: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
    }
    
    func startAnimation() {
        dotOne.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotTwo.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        dotThree.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            [weak self] in self?.dotOne.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: [.repeat, .autoreverse], animations: {
            [weak self] in self?.dotTwo.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            [weak self] in self?.dotThree.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
}

