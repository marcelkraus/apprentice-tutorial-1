//
//  ViewController.swift
//  BullsEye
//
//  Created by Marcel Kraus on 21.07.17.
//  Copyright © 2017 Marcel Kraus. All rights reserved.
//

import UIKit

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
        startNewRound()
        updateLabels()
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference

        score += points

        let alert = UIAlertController(
            title: "Hello World!",
            message: "You scored \(points) points",
            preferredStyle: .alert
        )
        let action = UIAlertAction (
            title: "OK",
            style: .default,
            handler: nil
        )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        startNewRound()
        updateLabels()
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
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
