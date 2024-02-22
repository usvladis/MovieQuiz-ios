//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 12.02.2024.
//

import Foundation
protocol QuestionFactoryProtocol {
    var delegate: QuestionFactoryDelegate? {get set}
    func requestNextQuestion()
}
