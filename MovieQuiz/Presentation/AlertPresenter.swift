//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 12.02.2024.
//

import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    
    weak var delegate: AlertPresenterDelegate?
    
    func showAlert(model: AlertModel) {
        let alertController = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        alertController.addAction(alertAction)
        delegate?.show(alert: alertController)
    }
    
}
