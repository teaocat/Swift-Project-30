//
//  ViewController.swift
//  LoveTweet
//
//  Created by Teaocat on 2018/1/6.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ViewController: UIViewController {
    var tweet: Tweet?
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSeg: UISegmentedControl!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var workTextField: UITextField!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var straightSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector.endEditing))
        
        nameTextField.delegate = self
        workTextField.delegate = self
    }
    
    @IBAction func salarySliderValueDidChange(_ sender: UISlider) {
        salaryLabel.text = "$\(Int(sender.value))k"
    }
    
    @IBAction func tweetItButtonDidClick(_ sender: UIButton) {
        func getLabesInfo() -> (name: String?, work: String?, salary: String?) {
            guard let name = nameTextField.text, let work = workTextField.text, let salary = salaryLabel.text else {
                return (nil, nil, nil)
            }
            
            if name.isEmpty || work.isEmpty || salary.isEmpty {
                return (nil, nil, nil)
            }
            
            return (name, work, salary)
        }
        
        func getAge() -> Int? {
            let ageComponents = Calendar.current.dateComponents([.year], from: birthdayPicker.date, to: Date())
            return ageComponents.year
        }
        
        let info = getLabesInfo()
        
        if let name = info.name, let work = info.work, let salary = info.salary, let age = getAge() {
            tweet = Tweet(gender: Gender(rawValue: genderSeg.selectedSegmentIndex)! , name: name, age: age, work: work, salary: salary, isStraight: straightSwitch.isOn)
        } else {
            tweet = nil
        }
        
        switch tweet {
        case .some(let tweet):
            showAlert(title: "Love Tweet",
                      message: tweet.info,
                      buttonTitle: "OK")
        case .none:
            showAlert(title: "Info miss or invalid",
                      message: "Please fill out correct personal info",
                      buttonTitle: "OK")
        }
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
