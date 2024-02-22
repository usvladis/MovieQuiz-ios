//
//  QuestionFactory.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 12.02.2024.
//

import Foundation

final class QuestionFactory: QuestionFactoryProtocol{
    weak var delegate: QuestionFactoryDelegate?
    private var shuffledQuestions: [QuizQuestion] = []
        
    
    private let questions: [QuizQuestion] = [ //Массив с вопросами
        QuizQuestion(image:"The Godfather", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Dark Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Kill Bill", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Avengers", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Deadpool", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "The Green Knight", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: true),
        QuizQuestion(image: "Old", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "The Ice Age Adventures of Buck Wild", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Tesla", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false),
        QuizQuestion(image: "Vivarium", text: "Рейтинг этого фильма больше чем 6?", correctAnswer: false)
    ]
    
//    func requestNextQuestion() {
//        guard let index = (0..<questions.count).randomElement() else{
//            delegate?.didReceiveNextQuestion(question: nil)
//            return
//        }
//        let questions = questions[safe: index]
//        delegate?.didReceiveNextQuestion(question: questions)
//    }
    
    func requestNextQuestion() {
        if shuffledQuestions.isEmpty {
            shuffledQuestions = questions.shuffled()
        }
        let question = shuffledQuestions.removeLast()// Удаляем и возвращаем последний вопрос из копии массива
        delegate?.didReceiveNextQuestion(question: question)
    }
}
