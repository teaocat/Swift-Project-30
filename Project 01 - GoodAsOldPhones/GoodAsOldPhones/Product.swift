//
//  Product.swift
//  GoodAsOldPhones
//
//  Created by Teaocat on 2018/1/4.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import Foundation

class Product {
    var name: String?
    var cellImageNamed: String?
    var fullscreenImageNamed: String?
    
    init (name: String, cellImageNamed: String, fullscreenImageNamed: String) {
        self.name = name
        self.cellImageNamed = cellImageNamed
        self.fullscreenImageNamed = fullscreenImageNamed
    }
    
}
