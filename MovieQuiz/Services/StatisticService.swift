//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 16.02.2024.
//

import Foundation

protocol StatisticService{
    func store(correct count: Int, total amount: Int)
    var totalAccuracy: Double {get}
    var totalGames: Int {get}
    var bestGame: GameRecord {get}
}
