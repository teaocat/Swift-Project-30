//
//  ProductViewController.swift
//  GoodAsOldPhones
//
//  Created by Teaocat on 2018/1/4.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        productNameLabel.text = product?.name
        
        if let imageNamed = product?.fullscreenImageNamed {
            productImageView.image = UIImage(named: imageNamed)
        }
        
    }
    
    @IBAction func addToCartButtonDidTap(_ sender: Any) {
        print("Add to cart successfully")
    }
    
}
