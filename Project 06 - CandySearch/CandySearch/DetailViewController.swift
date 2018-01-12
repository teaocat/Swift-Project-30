//
//  DetailViewController.swift
//  CandySearch
//
//  Created by Teaocat on 2018/1/12.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Variable
    var candy: Candy? {
        // 属性观察器 didSet 在新的值被设置之后立即调用
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let candy = candy {
            if let titleLabel = titleLabel, let imageView = imageView {
                titleLabel.text = candy.name
                imageView.image = UIImage(named: candy.name)
                title = candy.category
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    /*
     下意识我就这么写了......................
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let candy = candy else {
            return
        }
        
        title = candy.category
        
        titleLabel.text = candy.name
        imageView.image = UIImage(named: candy.name)
    }
     */
}
