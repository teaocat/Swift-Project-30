//
//  ViewController.swift
//  Todo
//
//  Created by Teaocat on 2018/1/10.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

var todos: [TodoItem] = []

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var todoTableView: UITableView!

    // MARK: - Root View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        todos = [TodoItem(id: "1", image: "child-selected", title: "Tea", date: dateFromString("2016-01-10")!),
                 TodoItem(id: "2", image: "phone-selected", title: "o", date: dateFromString("2016-01-10")!),
                 TodoItem(id: "3", image: "shopping-cart-selected", title: "cat", date: dateFromString("2016-01-10")!),
                 TodoItem(id: "4", image: "travel-selected", title: "teocat", date: dateFromString("2016-01-10")!)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoTableView.reloadData()
    }
    
    // MARK: - helper func
    func setMessageLabel(_ label: UILabel, frame: CGRect, text: String, textColor: UIColor, numberOfLines: Int, textAlignment: NSTextAlignment, font: CGFloat) {
        label.frame = frame
        label.text = text
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        label.font = UIFont.systemFont(ofSize: font)
        label.sizeToFit()
    }
    
    func configureCell(_ cell: UITableViewCell, todoItem: TodoItem) {
        let imageView = cell.viewWithTag(11) as! UIImageView
        let titleLabel = cell.viewWithTag(12) as! UILabel
        let detailLabel = cell.viewWithTag(13) as! UILabel
        
        imageView.image = UIImage(named: todoItem.image)
        titleLabel.text = todoItem.title
        detailLabel.text = stringFromDate(todoItem.date)
    }
    
    // MARK: - Actions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTodo" {
            let vc = segue.destination as! DetailViewController
            let indexPath = todoTableView.indexPathForSelectedRow
            vc.todo = todos[indexPath!.row]
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todos.count != 0 {
            todoTableView.backgroundView = nil
            todoTableView.separatorStyle = .singleLine
            return todos.count
        } else {
            let messageLabel = UILabel()
            setMessageLabel(messageLabel, frame: CGRect(x: 0, y: 0, width: todoTableView.bounds.width, height: todoTableView.bounds.height), text: "Todo列表暂时没有消息", textColor: .black, numberOfLines: 0, textAlignment: .center, font: 20)
            todoTableView.backgroundView = messageLabel
            todoTableView.separatorStyle = .none
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "todoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configureCell(cell, todoItem: todos[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    // Edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        todoTableView.setEditing(editing, animated: true)
    }
    
    // Delete the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Move the cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoItem = todos.remove(at: sourceIndexPath.row)
        todos.insert(todoItem, at: destinationIndexPath.row)
    }
}
