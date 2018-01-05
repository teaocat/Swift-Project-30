//
//  ProductsTableViewController.swift
//  GoodAsOldPhones
//
//  Created by Teaocat on 2018/1/4.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ProductsTableViewController: UITableViewController {
    fileprivate var products: [Product]?
    fileprivate let identifier = "productCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        products = [
            Product(name: "1907 Wall Set", cellImageNamed: "image-cell1", fullscreenImageNamed: "phone-fullscreen1"),
            Product(name: "1921 Dial Phone", cellImageNamed: "image-cell2", fullscreenImageNamed: "phone-fullscreen2"),
            Product(name: "1937 Desk Set", cellImageNamed: "image-cell3", fullscreenImageNamed: "phone-fullscreen3"),
            Product(name: "1984 Moto Portable", cellImageNamed: "image-cell4", fullscreenImageNamed: "phone-fullscreen4")
        ]
    }
    
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let products = products else { return cell }
        
        cell.textLabel?.text = products[indexPath.row].name
        
        if let cellImageNamed = products[indexPath.row].cellImageNamed {
            cell.imageView?.image = UIImage(named: cellImageNamed)
        }
        
        
        return cell
    }
    
    // MARK: - View Transfer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier ?? "") == "showProduct" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let productVC = segue.destination as? ProductViewController {
                productVC.product = products?[indexPath.row]
            }
        }
    }
    
}
