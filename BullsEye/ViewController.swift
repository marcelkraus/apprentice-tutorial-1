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
    @IBOutlet weak var slider: UISlider!

    var currentValue = 0
    var targetValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
    }

    @IBAction func showAlert() {
        let message =
            "The value of the slider is: \(currentValue)" +
            "\nThe target value is: \(targetValue)"

        let alert = UIAlertController(
            title: "Hello World!",
            message: message,
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
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }

    func updateLabels() {
        targetLabel.text = String(targetValue)
    }

}
