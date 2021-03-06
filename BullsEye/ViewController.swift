//
//  ViewController.swift
//  BullsEye
//
//  Created by Marcel Kraus on 21.07.17.
//  Copyright © 2017 Marcel Kraus. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var slider: UISlider!

    var targetValue = 0
    var currentValue = 0
    var round = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewRound()
        updateLabels()
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference

        let title: String
        // Differs from tutorial, uses switch block instead of if block
        switch true {
        case difference == 0:
            title = "Perfect!"
            points += 100
        case difference < 5:
            title = "You've almost had it!"
            if difference == 1 {
                points += 50
            }
        case difference < 10:
            title = "Pretty good!"
        default:
            title = "Not even close…"
        }

        let message = "You scored \(points) points"

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action = UIAlertAction (
            title: "OK",
            style: .default,
            handler: { action in
                self.startNewRound()
                self.updateLabels()
            }
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        score += points
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }

    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        view.layer.add(transition, forKey: nil)
    }

    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }

    func startNewRound() {
        currentValue = 50
        slider.value = Float(currentValue)
        targetValue = 1 + Int(arc4random_uniform(100))
        round += 1
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
    }

}
