//
//  QuestionsFactory.swift
//  07-MathTraining
//
//  Created by Jair Benítez on 17/01/19.
//  Copyright © 2019 Jair Benítez. All rights reserved.
//

import Foundation

class QuestionsFactory {
    
    private var questions = [Question]()
    public private( set ) var score = 0
    
    
 
    
    // Inicializador
    
    init() {
        /*for _ in 0...10 {
            questions.append( createQuestion() )
        }*/
        
        addNewQuestion()
    }
    
    
    func addNewQuestion() {
        questions.insert(createQuestion(), at: 0)
    }
    
    
    
    func getQuestionAt(position: Int) -> Question? {
        if(position<0 || position > questions.count){
            return nil
        }
        return self.questions[position]
    }
 
    
    
    
    func numberOfQuestions() -> Int {
        return questions.count
    }
    
    
    
    
    func createQuestion() -> Question {
        var question = ""
        var correctAnswer = 0
        
        while true {
            let firstNumber = Int.random(in: 0...9)
            let secondNumber = Int.random(in: 0...9)
            
            if Bool.random() {
                let result = firstNumber + secondNumber
                
                if result < 10 {
                    question = "\(firstNumber) + \(secondNumber)"
                    correctAnswer = result
                    break
                }
            } else {
                let result = firstNumber - secondNumber
                
                if result >= 0 {
                    question = "\(firstNumber) - \(secondNumber)"
                    correctAnswer = result
                    break
                }
            }
        
        }
        
        return Question(text: question, answer: correctAnswer, userAnswer: nil )
    }
    
    
}
