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
        let title = "You scored \(calculateScore()) points"
        let message = "The value of the slider was \(currentValue)\nYou were aiming for \(targetValue)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Play Again", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        startNewRound()
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
            score += calculateScore()
        }
        targetValue = Int(arc4random_uniform(100) + 1)
        slider.value = 50
        round += 1
        updateLabels()
    }
    
    func calculateScore() -> Int {
        let offBy = targetValue - currentValue
        return 100 - abs(offBy)
    }
    
    func updateLabels() {
        targetValueLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
}
