//
//  TimerViewController.swift
//  Clock
//
//  Created by Diego Beluský on 05.02.2024.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var timer: Timer?
    var secondsRemaining = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        // Initially, hide the timerLabel and startButton
        timerLabel.isHidden = true
        //startButton.isHidden = true

        // Set the timePicker to show countdown mode
        timePicker.countDownDuration = 300 // Initial duration of 5 minutes
        timerLabel.font = UIFont(name: "Menlo", size: 55)
        styleButtons(startButton)
    }
    
    func styleButtons(_ button: UIButton) {
        button.backgroundColor = UIColor.systemBackground
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if timer == nil {
            secondsRemaining = Int(timePicker.countDownDuration)
            updateTimerLabel()
            startTimer()

            // Show the timerLabel and hide the timePicker and startButton
            timerLabel.isHidden = false
            timePicker.isHidden = true
            // startButton.isHidden = true
        } else {
            stopTimer()
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        startButton.setTitle("Reset", for: .normal)
    }

    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            updateTimerLabel()
        } else {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil

        // Show the timePicker and startButton, hide the timerLabel
        timerLabel.isHidden = true
        timePicker.isHidden = false
        startButton.isHidden = false
        timerLabel.text = "00:00:00"

        startButton.setTitle("Start", for: .normal)
    }

    func updateTimerLabel() {
        let hours = secondsRemaining / 3600
        let minutes = (secondsRemaining % 3600) / 60
        let seconds = secondsRemaining % 60

        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)

        timerLabel.text = timeString
    }
}

