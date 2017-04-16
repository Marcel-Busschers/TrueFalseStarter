//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = answers.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var previousQuestionsAsked: [Int] = []
    
    
    //variables for sounds
    var gameSound: SystemSoundID = 0
    var gameEnd: SystemSoundID = 0
    var timerEnd: SystemSoundID = 0
    var correctAnswer: SystemSoundID = 0
    var wrongAnswer: SystemSoundID = 0
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    
    // For the timer
    @IBOutlet weak var timer: UILabel!
    var seconds = 15
    var lightningTimer = Timer()
    var timerIsRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllSounds()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: answers.count)
        
        // While loop to make sure the questions are not repeated
        while previousQuestionsAsked.contains(indexOfSelectedQuestion){
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: answers.count)
        }
        
        //Append the previous asked question to the array
        previousQuestionsAsked.append(indexOfSelectedQuestion)
        
        let questionDictionary = answers[indexOfSelectedQuestion]
        questionField.text = questionDictionary.question
        
        // Setting each button to their corrosponding answer option
        firstOption.setTitle(questionDictionary.answers[0], for: UIControlState())
        secondOption.setTitle(questionDictionary.answers[1], for: UIControlState())
        thirdOption.setTitle(questionDictionary.answers[2], for: UIControlState())
        fourthOption.setTitle(questionDictionary.answers[3], for: UIControlState())
        playAgainButton.isHidden = true
        
        timer.isHidden = false
        enableButtons()
        timerReset()
        beginTimer()
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstOption.isHidden = true
        secondOption.isHidden = true
        thirdOption.isHidden = true
        fourthOption.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = answers[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        if sender.titleLabel!.text == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
            lightningTimer.invalidate()
            playCorrectAnswerSound()
            disableButtons()
        } else {
            // Appropriately showing the correct answer in hte questionField
            questionField.text = "Sorry, wrong answer! Correct answer was: \(correctAnswer)"
            lightningTimer.invalidate()
            playWrongAnswerSound()
            disableButtons()
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            playGameEndSound()
            timer.isHidden = true
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        firstOption.isHidden = false
        secondOption.isHidden = false
        thirdOption.isHidden = false
        fourthOption.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    
    
    
    // MARK: Helper Methods
    
    //For the lightning timer to be reset
    func timerReset() {
        seconds = 15
        timer.text = "\(seconds) Seconds Remaining"
        timerIsRunning = false
    }
    func countdownTimer() {
        let selectedQuestionDict = answers[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAnswer
        
        seconds -= 1
        timer.text = "\(seconds) Seconds Remaining"
        
        if seconds == 0 {
            lightningTimer.invalidate()
            questionsAsked += 1
            questionField.text = "Oh no! You ran out of time! The correct answer was: \(correctAnswer)"
            
            playTimerEndSound()
            disableButtons()
            loadNextRoundWithDelay(seconds: 2)
        }
    }
    func beginTimer() {
        if timerIsRunning == false {
            lightningTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdownTimer), userInfo: nil, repeats: true)
            
            timerIsRunning = true
        }
    }
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    //Sounds
    /// GameStart
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    /// GameEnd
    func loadGameEndSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameEnd", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameEnd)
    }
    func playGameEndSound() {
        AudioServicesPlaySystemSound(gameEnd)
    }
    
    ///TimerEnd
    func loadTimerEndSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "TimerEnd", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &timerEnd)
    }
    func playTimerEndSound() {
        AudioServicesPlaySystemSound(timerEnd)
    }
    
    ///CorrectAnswer
    func loadCorrectAnswerSound() {
        let pathToSound = Bundle.main.path(forResource: "CorrectAnswer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSound!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctAnswer)
    }
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswer)
    }
    
    ///WrongAnswer
    func loadWrongAnswerSound() {
        let pathToSound = Bundle.main.path(forResource: "WrongAnswer", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSound!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &wrongAnswer)
    }
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(wrongAnswer)
    }
    
    // to Load all sounds
    func loadAllSounds() {
        loadGameStartSound()
        loadGameEndSound()
        loadTimerEndSound()
        loadCorrectAnswerSound()
        loadWrongAnswerSound()
    }
    
    // To Disable and Enable the buttons, as when you spam them, multiple errors occur that we dont want:
    func enableButtons() {
        firstOption.isEnabled = true
        secondOption.isEnabled = true
        thirdOption.isEnabled = true
        fourthOption.isEnabled = true
    }
    func disableButtons() {
        firstOption.isEnabled = false
        secondOption.isEnabled = false
        thirdOption.isEnabled = false
        fourthOption.isEnabled = false
    }
}

// Refference: 
/* 
 http://stackoverflow.com/questions/24007518/how-can-i-use-nstimer-in-swift

 Optional Features:
 -Lightning Timer Implemented
 -Tells you the correct answer when get it wrong
 -Added sound effects for: Correct, Incorrect, Timer Ending and Game ending
 */

