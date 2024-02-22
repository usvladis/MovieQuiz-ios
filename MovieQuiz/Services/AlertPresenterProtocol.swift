//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 13.02.2024.
//

import Foundation
protocol AlertPresenterProtocol {
    var delegate: AlertPresenterDelegate? {get set}
    func showAlert(model: AlertModel)
}
