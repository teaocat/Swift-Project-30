//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Created by Teaocat on 2018/3/2.
//  Copyright © 2018年 learning-swift. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class FeedParser: NSObject {
    fileprivate var rssItems = [(title: String, description: String, pubDate: String)]()
    
    fileprivate var currentElement = ""
    
    fileprivate var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var parserCompletionHandler: (([(title: String, description: String, pubDate: String)]) -> Void)?
    
    func parseFeed(feedURL: String, completionHandler: (([(title: String, description: String, pubDate: String)]) -> Void)?) -> Void {
        
        parserCompletionHandler = completionHandler
        
        guard let feedURL = URL(string: feedURL) else {
            print("feed URL is invalid")
            return
        }
        
        URLSession.shared.dataTask(with: feedURL) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data fetched")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }.resume()
        
    }
    
}

// MARK: - 解析XML格式数据
extension FeedParser: XMLParserDelegate {
    // 解析XML: 开始解析,并空rssItems里的所有内容
    func parserDidStartDocument(_ parser: XMLParser) {
        rssItems.removeAll()
    }
    
    // 解析XML: 获取当前的起始标签元素
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    // 解析XML: 获取当前标签元素的文本元素
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }
    
    // 解析XML: 获取当前的结束标签元素
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            rssItems.append(rssItem)
        }
    }
    
    // 解析XML: 解析完毕
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    // 解析XML: 解析出错调用该函数
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
