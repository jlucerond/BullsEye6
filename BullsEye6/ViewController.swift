//
//  ViewController.swift
//  BullsEye6
//
//  Created by Joe Lucero on 3/4/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit
import QuartzCore

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
        setUpSlider()
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
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
}


// - MARK: Slider Properties &  Functionality
extension ViewController {
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("Slider value: \(slider.value)")
    }
    
    func setUpSlider() {
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
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
