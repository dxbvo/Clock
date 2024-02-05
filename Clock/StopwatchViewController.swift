//
//  ViewController.swift
//  Clock
//
//  Created by Diego Beluský on 05.02.2024.
//

import UIKit

class StopwatchViewController: UIViewController {
        
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var timer: Timer?
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    func styleButton(_ button: UIButton) {
        button.backgroundColor = UIColor.systemBackground
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    // Functions when tapped
    @IBAction func startButtonTapped(_ sender: UIButton) {
        startTimer()
        updateButtonState(startEnabled: false, stopEnabled: true, resetEnabled: false)
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopTimer()
        updateButtonState(startEnabled: true, stopEnabled: false, resetEnabled: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetTimer()
        updateButtonState(startEnabled: true, stopEnabled: false, resetEnabled: false)
    }
    
    func configureButtons() {
        // button design
        styleButton(startButton)
        styleButton(stopButton)
        styleButton(resetButton)
        // Set up initial state of buttons
        startButton.isEnabled = true
        stopButton.isEnabled = false
        resetButton.isEnabled = true
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
    }
    
    @objc func updateClock() {
        seconds += 1
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        clockLabel.text = timeString
    }
    
    func updateButtonState(startEnabled: Bool, stopEnabled: Bool, resetEnabled: Bool) {
        startButton.isEnabled = startEnabled
        stopButton.isEnabled = stopEnabled
        resetButton.isEnabled = resetEnabled
    }
    
    func resetTimer() {
        stopTimer()
        seconds = 0
        clockLabel.text = "00:00:00"
    }
    

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
}

