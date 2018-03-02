//
//  ViewController.swift
//  SimpleRSSReader
//
//  Created by Teaocat on 2018/3/2.
//  Copyright © 2018年 learning-swift. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FeedParser().parseFeed(feedURL: "http://www.apple.com/main/rss/hotnews/hotnews.rss") { rssItems in
            let title = rssItems[0].title
            print(title)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

