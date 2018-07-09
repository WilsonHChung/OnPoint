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
    var targetValueTwo = 0
    var targetValueThree = 0
    
    //var targetValue = Array(repeating: 0, count: 3)
    
    // Initializes the random number generator the user has to guess
    
    var score = 0
    // Initializes the scoring system of the game
    
    var round = 1
    // Intializes the round system of the game
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetLabelTwo: UILabel!
    @IBOutlet weak var targetLabelThree: UILabel!
    //@IBOutlet var targetLabels: Array<UILabel>?

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentValue = lroundf(slider.value)
        gameReset()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    // Refreshes the randomized number
    
    func startNewRound() {
        //for i in targetValue {
            targetValue = 1 + Int(arc4random_uniform(100))
        //}
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
    
    @IBAction func gameReset() {
        score = 0
        round = 1
        startNewRound()
    }
    // Resets the game from the beginning as if you restarted the app
    
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "You're OnPoint!"
            points = 100
        }
        else if difference <= 2 {
            title = "Almost"
            points = 50
        } else {
            title = "Oof try again"
            points = 0
        }
        
        score += points
        round += 1
        
        let message = "You scored: \(points) points\n"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Alerts user with a notification containing a title and a message
        
        let action = UIAlertAction(title: "Continue", style: .default, handler: {
            action in
                self.startNewRound()
        })
        // Allows user to dismiss the message/view controller
        
        alert.addAction(action)
        // Connects the user action to the prompted alert
        
        present(alert, animated: true, completion: nil)
        // Presents the alert onto the iOS device's screen
        
    }
  
}

