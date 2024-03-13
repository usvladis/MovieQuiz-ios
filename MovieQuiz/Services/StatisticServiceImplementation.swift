//
//  StatisticServiceImplementation.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 16.02.2024.
//

import Foundation

class StatisticServiceImplementation: StatisticService{
    private let userDefaults = UserDefaults.standard
    private enum Keys: String {
        case correct, total, bestGame, gamesCount, totalAccuracy
    }
    func store(correct count: Int, total amount: Int) {
        var currentBestGame = bestGame
        let newRecord = GameRecord(correct: count, total: amount, date: Date())
        if newRecord.correct > currentBestGame.correct {
            currentBestGame = newRecord
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(currentBestGame) {
                userDefaults.set(encoded, forKey: Keys.bestGame.rawValue)
            }
            
        }
        var totalGames = userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        totalGames += 1
        userDefaults.set(totalGames, forKey: Keys.gamesCount.rawValue)
        var corrects = userDefaults.integer(forKey: Keys.correct.rawValue)
        corrects += count
        userDefaults.set(corrects, forKey: Keys.correct.rawValue)
        
        var total = userDefaults.integer(forKey: Keys.total.rawValue)
        total += amount
        userDefaults.set(total, forKey: Keys.total.rawValue)
        totalAccuracy = Double(corrects)/Double(total)*100
    }
    
    var totalAccuracy: Double {
        get {
            return userDefaults.double(forKey: Keys.totalAccuracy.rawValue)
        }
        set {
            userDefaults.setValue(newValue, forKey: Keys.totalAccuracy.rawValue)
        }
    }
    
    var totalGames: Int {
        get {
            return userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
}
