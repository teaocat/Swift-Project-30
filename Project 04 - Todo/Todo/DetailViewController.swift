//
//  DetailViewController.swift
//  Todo
//
//  Created by Teaocat on 2018/1/10.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class DetailViewController: UIViewController {
    
    var todo: TodoItem?
    
    // MARK: - Outlets
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoTitleField: UITextField!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let todo = todo else {
            title = "New Todo"
            childButton.isSelected = true
            return
        }
        
        switch todo.image {
        case "child-selected":
            childButton.isSelected = true
        case "phone-selected":
            phoneButton.isSelected = true
        case "shopping-cart-selected":
            shoppingButton.isSelected = true
        default:
            travelButton.isSelected = true
        }
        todoTitleField.text = todo.title
        todoDatePicker.setDate(todo.date, animated: false)
    }
    
    // MARK: - Actions
    
    @IBAction func selectedChild(_ sender: UIButton) {
        resetSelectedButton()
        sender.isSelected = true
    }
    
    @IBAction func selectedPhone(_ sender: UIButton) {
        resetSelectedButton()
        sender.isSelected = true
    }
    
    @IBAction func selectedShopping(_ sender: UIButton) {
        resetSelectedButton()
        sender.isSelected = true
    }
    
    @IBAction func selectedTravel(_ sender: UIButton) {
        resetSelectedButton()
        sender.isSelected = true
    }
    
    func resetSelectedButton() -> Void {
        childButton.isSelected = false
        phoneButton.isSelected = false
        shoppingButton.isSelected = false
        travelButton.isSelected = false
    }
    
    @IBAction func doneButtonDidClick(_ sender: Any) {
        var image = ""
        if childButton.isSelected {
            image = "child-selected"
        } else if phoneButton.isSelected {
            image = "phone-selected"
        } else if shoppingButton.isSelected {
            image = "shopping-cart-selected"
        } else {
            image = "travel-selected"
        }
        
        if let todo = todo {
            todo.image = image
            todo.title = todoTitleField.text!
            todo.date = todoDatePicker.date
        } else {
            let uuid = UUID().uuidString
            todo = TodoItem(id: uuid, image: image, title: todoTitleField.text!, date: todoDatePicker.date)
            todos.append(todo!)
        }
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
