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

class NewsTableViewController: UITableViewController {
    
    // MARK: Variable
    fileprivate var feedParser = FeedParser()
    fileprivate var feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    
    fileprivate var rssItems: [(title: String, description: String, pubDate: String)]?
    fileprivate var cellStates: [CellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置tableViewCell的预处理高度和下划线样式
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = .singleLine
        
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            self?.rssItems = rssItems
            self?.cellStates = Array(repeating: .collapsed, count: rssItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        if let item = rssItems?[indexPath.row] {
            (cell.titleLabel.text, cell.pubDateLabel.text, cell.descriptionLabel.text) = (item.title, item.pubDate, item.description)
            
            if let cellState = cellStates?[indexPath.row] {
                cell.descriptionLabel.numberOfLines = cellState == .expanded ? 0 : 4
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        
        tableView.beginUpdates()
//        if let cellState = cellStates?[indexPath.row] {
//            cellStates?[indexPath.row] = cellState == .collapsed ? .expanded : .collapsed
//            cell.descriptionLabel.numberOfLines = cellStates?[indexPath.row] == .expanded ? 0 : 4
//        }
        cell.descriptionLabel.numberOfLines = cell.descriptionLabel.numberOfLines == 4 ? 0 : 4
        cellStates?[indexPath.row] = cell.descriptionLabel.numberOfLines == 4 ? .collapsed : .expanded
        tableView.endUpdates()
    }
}

