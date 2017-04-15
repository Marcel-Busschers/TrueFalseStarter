//
//  questions.swift
//  TrueFalseStarter
//
//  Created by Marcel Busschers on 2017/02/01.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

//A class to set up a question with 4 possible answers

class Question {
    let question: String
    let answers: [String]
    let correctAnswer: String
    init(question: String, firstOption: String, secondOption: String, thirdOption: String, fourthOption: String, correctAnswer: String) {
        self.answers = [firstOption,secondOption,thirdOption,fourthOption]
        self.correctAnswer = correctAnswer
        self.question = question
    }
}

//A bunch of questions using the Question class

let question1 = Question(question: "In which European city can you find the home of Anne Frank?", firstOption: "Germany", secondOption: "Amsterdam", thirdOption: "Poland", fourthOption: "France", correctAnswer: "Amsterdam")
let question2 = Question(question: "How many stars does the American Flag have?", firstOption: "52", secondOption: "51", thirdOption: "55", fourthOption: "50", correctAnswer: "50")
let question3 = Question(question: "How long is the Great Wall of China?", firstOption: "4000 miles", secondOption: "6000 miles", thirdOption: "3000 miles", fourthOption: "10 000 miles", correctAnswer: "4000 miles")
let question4 = Question(question: "What colour to do you get when you mix red and white?", firstOption: "Grey", secondOption: "Orange", thirdOption: "Pink", fourthOption: "Maroon", correctAnswer: "Pink")
let question5 = Question(question: "Whats the longest river?", firstOption: "Nile", secondOption: "Amazon", thirdOption: "Orange", fourthOption: "Missippi", correctAnswer: "Nile")
let question6 = Question(question: "What age was Queen Elizabeth II at her coronation in 1953?", firstOption: "33", secondOption: "25", thirdOption: "27", fourthOption: "20", correctAnswer: "27")
let question7 = Question(question: "Hawaii is the biggest producer of which fruit?", firstOption: "Coconut", secondOption: "Persimmon", thirdOption: "Plum", fourthOption: "Pineapple", correctAnswer: "Pineapple")
let question8 = Question(question: "West Jet Airlines are based in which country?", firstOption: "Canada", secondOption: "UK", thirdOption: "USA", fourthOption: "France", correctAnswer: "Canada")
let question9 = Question(question: "Which animal is the subject of the 1984 film ‘A Private Function’?", firstOption: "Cow", secondOption: "Pig", thirdOption: "Lamb", fourthOption: "Hamster", correctAnswer: "Pig")
let question10 = Question(question: "Which US musician played the role of Alias in the 1973 film ‘Pat Garrett and Billy the Kid’?", firstOption: "Bod Dylan", secondOption: "John Stewart", thirdOption: "Billy Joan", fourthOption: "Michael Jackson", correctAnswer: "Bod Dylan")

//A array list of all questions that were made with the Question class

let answers = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]










