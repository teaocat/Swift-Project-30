//
//  ViewController.swift
//  Stopwatch
//
//  Created by Teaocat on 2018/1/7.
//  Copyright © 2018年 school. All rights reserved.
//
//  Github: https://github.com/teaocat
//
    

import UIKit

class ViewController: UIViewController {
    // MARK: - Variable
    fileprivate var mainStopwatch: Stopwatch = Stopwatch()
    fileprivate var lapStopwatch: Stopwatch = Stopwatch()
    fileprivate var isPlay: Bool = false
    fileprivate var laps: [String] = []
    
    // MARK: - Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    // MARK: - UI Settings

}

