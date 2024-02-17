//
//  GameRecord.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 16.02.2024.
//

import Foundation
struct GameRecord: Codable{
    let correct: Int
    let total: Int
    let date: Date
    
//    mutating func resultComparsion (newGame: GameRecord) {
//        if newGame.correct > correct {
//            correct = newGame.correct
//            total = newGame.total
//            date = newGame.date
//        }
//    }
    func isBetterThan(_ another: GameRecord) -> Bool {
            correct > another.correct
        }
}
