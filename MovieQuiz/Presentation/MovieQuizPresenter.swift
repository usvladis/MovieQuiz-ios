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
    private var statisticService: StatisticService?
    private var alertPresenter: AlertPresenterProtocol?
    var questionFactory: QuestionFactoryProtocol?
    var correctAnswers: Int = 0




    
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
        didAnswer(isYes: true)
    }
    
    func noButtonClicked() {
        didAnswer(isYes: false)
    }
    
    private func didAnswer(isYes: Bool) {
        let checkAnswer = isYes
        guard let currentQuestion = currentQuestion else {return}
        viewController?.showAnswerResult(isCorrect: checkAnswer == currentQuestion.correctAnswer)
        viewController?.buttonBlock()
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else { return}
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    func showNextQuestionOrResult() {
        if self.isLastQuestions() {
            let text = "Вы ответили на \(correctAnswers) из 10, попробуйте еще раз!"

            let viewModel = QuizResultsViewModel(
                title: "Игра закончена!",
                text: text,
                buttonText: "Сыграть еще раз")
            viewController?.show(quiz: viewModel)//Выводим алерт в случае если вопросы закончились
        }else{
            self.switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
    
    
}
