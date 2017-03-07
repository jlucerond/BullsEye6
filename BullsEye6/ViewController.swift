//
//  ViewController.swift
//  BullsEye6
//
//  Created by Joe Lucero on 3/4/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Variables
    var currentValue: Int {
        return lroundf(slider.value)
    }
    var targetValue: Int = 0
    var round: Int = 0
    var score: Int = 0
    
    // MARK: - IBOutlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    // MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    // MARK: - IBActions
    @IBAction func showAlert() {
        let title = calculateTitle()
        let message = "The value of the slider was \(currentValue)\nYou were aiming for \(targetValue)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Play Again", style: .default, handler: {action in self.startNewRound()})
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func restartGame() {
        startNewGame()
    }
    
}


// - MARK: Slider Functionality
extension ViewController {
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("Slider value: \(slider.value)")
    }
}

// - MARK: Game Functionality
extension ViewController {
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        if round != 0 {
            score += calculateScore().modifiedScore
        }
        targetValue = Int(arc4random_uniform(100) + 1)
        slider.value = 50
        round += 1
        updateLabels()
    }
    
    func calculateTitle() -> String {
        let simpleScore = calculateScore().simpleScore
        let modifiedScore = calculateScore().modifiedScore
        
        if simpleScore == 100 {
            return "Perfect 💯: \(modifiedScore) points"
        } else if simpleScore >= 95 {
            return "Well done 👏🏽: \(modifiedScore) points"
        } else if simpleScore >= 90 {
            return "Ummm 🆗: \(modifiedScore) points"
        } else {
            return "Needs work 😕: \(modifiedScore) points"
        }
    }
    
    func calculateScore() -> (simpleScore: Int, modifiedScore: Int) {
        let offBy = targetValue - currentValue
        let simpleScore = 100 - abs(offBy)
        let modifiedScore: Int
        if simpleScore == 100 {
            modifiedScore = 200
        } else if simpleScore >= 95 {
            modifiedScore = 50 + simpleScore
        } else {
            modifiedScore = simpleScore
        }
        
        return (simpleScore, modifiedScore)
    }
    
    func updateLabels() {
        targetValueLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}
