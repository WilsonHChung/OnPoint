//
//  ViewController.swift
//  OnPoint
//
//  Created by Wilson H Chung on 6/20/18.
//  Copyright © 2018 wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    // Initializes the slider
    
    var targetValue = 0
    // Initializes the random number generator the user has to guess
    
    var score = 0
    // Initializes the scoring system of the game
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentValue = lroundf(slider.value)
        startNewRound()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
    }
    // Refreshes the randomized number
    
    func startNewRound() {
        
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
        
    }
    // Resets the current game round to a new one
    
    @IBAction func sliderMoved(_ slider: UISlider) {
    
        print("The value of slider is now: \(slider.value)")
        // Prints out the value of the object slider on the xcode terminal
        
        currentValue = lroundf(slider.value)
        // Rounds the float in the parameter to the nearest integer value
        
    }
    
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
    
        score += points
        
        let message = "Your scored: \(points) points\n" 
        
        let alert = UIAlertController(title: "Hello, World!", message: message, preferredStyle: .alert)
        // Alerts user with a notification containing a title and a message
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
        // Allows user to dismiss the message/view controller
        
        alert.addAction(action)
        // Connects the user action to the prompted alert
        
        present(alert, animated: true, completion: nil)
        // Presents the alert onto the iOS device's screen
        
        scoreLabel.text = String(score)
        
        startNewRound()
        
    }
  
}

