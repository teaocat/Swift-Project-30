//
//  Tweet.swift
//  LoveTweet
//
//  Created by Teaocat on 2018/1/6.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import Foundation

struct Tweet {
    var gender : Gender
    var name: String
    var age: Int
    var work: String
    var salary: String
    var isStraight: Bool
    
    var interestedGender: String {
        switch gender {
        case .Male:
            return isStraight ? "Women" : "Men"
        case .Famale:
            return isStraight ? "Men" : "Women"
        }
    }
    
    var info: String {
        return "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year, I am interested in \(interestedGender). Feel free to contact me!"
    }
    
}
