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
    var currentValueTwo = 0
    var currentValueThree = 0
    // Initializes the slider
    
    
    var targetValue = 0
    var targetValueTwo = 0
    var targetValueThree = 0
    
    //var targetValue = Array(repeating: 0, count: 3)
    
    // Initializes the random number generator the user has to guess
    
    var round = 1
    // Intializes the round system of the game
    
    var highestRound = 0
    
    var score = 0
    // Initializes the scoring system of the game
    
    var highestScore = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderTwo: UISlider!
    @IBOutlet weak var sliderThree: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetLabelTwo: UILabel!
    @IBOutlet weak var targetLabelThree: UILabel!
    //@IBOutlet var targetLabels: Array<UILabel>?

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highRoundLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentValue = lroundf(slider.value)
        currentValueTwo = lroundf(sliderTwo.value)
        currentValueThree = lroundf(sliderThree.value)
        gameReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        targetLabelTwo.text = String(targetValueTwo)
        targetLabelThree.text = String (targetValueThree)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    // Refreshes the randomized number
    
    func randomizer() {
        targetValue = 1 + Int(arc4random_uniform(100))
        targetValueTwo = 1 + Int(arc4random_uniform(100))
        targetValueThree = 1 + Int(arc4random_uniform(100))
    }
    // Randomizes the target values for each of the sliders
    
    func sliderInitial(){
        currentValue = 50
        slider.value = Float(currentValue)
        sliderTwo.value = Float(currentValue)
        sliderThree.value = Float(currentValue)
    }
    // Initializes the slider values for the start of the round
    
    func startNewGame() {
        score = 0
        round = 1
        randomizer()
        sliderInitial()
        updateLabels()
    }
    // Resets the current game round to a new round if the player is unable to score points
    
    func startNextRound() {
        randomizer()
        sliderInitial()
        updateLabels()
    }
    // Resets the current game round to the next round if the player is able to score points
    
    func saveHigh() {
        UserDefaults.standard.set(highestRound, forKey: "Hi-Round")
        UserDefaults.standard.set(highestScore, forKey: "Hi-Score")
        highRoundLabel.text = String(highestRound)
        highScoreLabel.text = String(highestScore)
    }
    // Saves the highest round and score of the user even when the app is closed
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The value of slider 1 is now: \(slider.value)")
        // Prints out the value of the object slider on the xcode terminal (Used for debugging)
        
        currentValue = lroundf(slider.value)
        // Rounds the float in the parameter to the nearest integer value
    }
    // Keeps track of the value of the first slider set by the user
    
    @IBAction func sliderMovedTwo(_ sliderTwo: UISlider){
        print("The value of slider 2 is now: \(sliderTwo.value)")
        currentValueTwo = lroundf(sliderTwo.value)
    }
    // Keeps track of the value of the second slider set by the user
    
    @IBAction func sliderMovedThree(_ sliderThree: UISlider){
        print("The value of slider 3 is now: \(sliderThree.value)")
        currentValueThree = lroundf(sliderThree.value)
    }
    // Keeps track of the value of the third slider set by the user
    
    
    @IBAction func gameReset() {
        score = 0
        round = 1
        startNewGame()
    }
    // Resets the game from the beginning as if you restarted the app
    
    
    @IBAction func showAlert() {
        let difference = abs((targetValue - currentValue) + (targetValueTwo - currentValueTwo) + (targetValueThree - currentValueThree))
        // Calculates difference of all three sliders with the user's slider value and in comparison to its respective given target value
        
        var points = 0
        var result = false
        // Used to determine whether the user scored points or not
        
        let title: String
        if difference == 0 {
            title = "You're OnPoint!"
            points = 100
        }
        else if difference <= 6 {
            title = "Almost"
            points = 10
        } else {
            title = "Oof try again"
            points = 0
            result = true
        }
        
        round += 1
        score += points
        
        let message = "You scored: \(points) points\n"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Alerts user with a notification containing a title and a message
        
        let action = UIAlertAction(title: "Continue", style: .default, handler: {
            action in
                if self.round > self.highestRound && self.score > self.highestScore {
                    self.highestRound = self.round
                    self.highestScore = self.score
                    self.saveHigh()
                }
                // The if statement keeps track of the highest round and score the user has achieved
                if (result == true) {
                    self.startNewGame()
                }
                else {
                    self.startNextRound()
                }
                // If the user was unable to score points, then the game resets to the beginning
                // If the user was able to score points, then the game starts the next round
        })
        // Allows user to dismiss the message/view controller
        
        alert.addAction(action)
        // Connects the user action to the prompted alert
        
        present(alert, animated: true, completion: nil)
        // Presents the alert onto the iOS device's screen
    }
}

