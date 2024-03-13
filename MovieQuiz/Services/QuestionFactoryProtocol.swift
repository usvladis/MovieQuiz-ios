//
//  QuestionFactoryProtocol.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 12.02.2024.
//

import Foundation
protocol QuestionFactoryProtocol: AnyObject {
    var delegate: QuestionFactoryDelegate? {get set}
    func requestNextQuestion()
    func loadData()
}
