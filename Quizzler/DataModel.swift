//
//  DataModel.swift
//  Quizzler
//
//  Created by Daniel on 16.07.2022.
//

import Foundation


struct QuestionsForQuiz {
    var question: String
    var correctAnswer: String
    var isUsedBefore: Bool
    
    static var questions = [QuestionsForQuiz(question: "There are 4 Maxwell's equations, right?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Is Russia the biggest country?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Did Max Verstappen win the 2021 FIA F1 Championship?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Did Rayan Gosling die at the end of 'Drive'?", correctAnswer: "false", isUsedBefore: false),
                            QuestionsForQuiz(question: "Did Red Bull win the 2021 FIA F1 Constructors Championship?", correctAnswer: "false", isUsedBefore: false),
                            QuestionsForQuiz(question: "Am i gonna be an iOS developer?", correctAnswer: "true", isUsedBefore: false),
                            QuestionsForQuiz(question: "Is Moscow the capital of Russia?", correctAnswer: "true", isUsedBefore: false)]
}
