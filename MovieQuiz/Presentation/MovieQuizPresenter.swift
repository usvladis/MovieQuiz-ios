//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 18.03.2024.
//

import UIKit

final class MovieQuizPresenter {
    
    private var currentQuestionIndex = 0
    let questionsAmount = 10
    var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewController?

    
    func isLastQuestions() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1) / \(questionsAmount)")
    }
    
    func yesButtonClicked() {
        let checkAnswer = true
        guard let currentQuestion = currentQuestion else {return}
        viewController?.showAnswerResult(isCorrect: checkAnswer == currentQuestion.correctAnswer)
        viewController?.buttonBlock()
    }
    
    func noButtonClicked() {
        let checkAnswer = false
        guard let currentQuestion = currentQuestion else {return}
        viewController?.showAnswerResult(isCorrect: checkAnswer == currentQuestion.correctAnswer)
        viewController?.buttonBlock()
    }
    
    
}
