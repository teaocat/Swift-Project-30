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
        
        let initCircleButton: (UIButton) -> Void = { button in
            button.layer.cornerRadius = button.bounds.width * 0.5
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        initCircleButton(playPauseButton)
        initCircleButton(lapResetButton)
        
        lapResetButton.isEnabled = false
        
        lapsTableView.delegate = self;
        lapsTableView.dataSource = self;
    }

    // MARK: - UI Settings
    // 设置不自动转向
    override var shouldAutorotate: Bool {
        return false
    }
    
    // 设置状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // 设置为竖屏方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    // MARK: - Control Actions
    
    @IBAction func PlayPauseButtonDidTap(_ sender: UIButton) {
        lapResetButton.isEnabled = true
        
        changeButton(lapResetButton, title: "Lap", color: .black)
        
        if !isPlay {
            isPlay = true
            
            changeButton(playPauseButton, title: "Stop", color: .red)
            
            // 设置定时器
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            // 添加到当前循环
            RunLoop.current.add(mainStopwatch.timer, forMode: .commonModes)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
        } else {
            isPlay = false
            
            // 清除定时器
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            
            changeButton(lapResetButton, title: "Reset", color: .black)
            changeButton(playPauseButton, title: "Start", color: .green)
        }
    }
    
    @IBAction func LapResetButtonDidTap(_ sender: UIButton) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapResetButton, title: "Lap", color: .lightGray)
            lapResetButton.isEnabled = false
        } else {
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
            }
            resetLapTimer()
            lapsTableView.reloadData()
            
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
        }
    }
    
    fileprivate func changeButton(_ sender: UIButton, title: String, color: UIColor) {
        sender.setTitle(title, for: .normal)
        sender.setTitleColor(color, for: .normal)
    }
    
    fileprivate func resetMainTimer() {
        resetTimer(mainStopwatch, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    fileprivate func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    fileprivate func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: timerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter += 0.035
        
        // 获取分钟
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\(Int(stopwatch.counter) / 60)"
        }
        
        // 获取秒钟
        var seconds: String = String(format:"%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        // 设置label
        label.text = minutes + ":" + seconds
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "lapCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let labelNum = cell.viewWithTag(20) as? UILabel {
            labelNum.text = "Lap\(laps.count - indexPath.row)"
        }
        if let labelTimer = cell.viewWithTag(18) as? UILabel {
            labelTimer.text = "\(laps[laps.count - indexPath.row - 1])"
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension
fileprivate extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
