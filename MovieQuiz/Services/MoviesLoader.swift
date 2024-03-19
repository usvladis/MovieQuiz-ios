//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Владислав Усачев on 01.03.2024.
//

import Foundation

protocol MoviesLoading{
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading{
    // MARK: - NetworkClient
    private let networkClient: NetworkRouting
    
    init(networkClient: NetworkRouting = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: - URL
    private var mostPopularMoviesUrl: URL{
        guard let url = URL(string: "https://tv-api.com/en/API/Top250Movies/k_zcuw1ytf") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
            case .success(let data):
                do {
                    // Пытаемся преобразовать полученные данные в экземпляр типа MostPopularMovies
                    let decoder = JSONDecoder()
                    let mostPopularMovies = try decoder.decode(MostPopularMovies.self, from: data)
                    // Возвращаем результат в обработчик
                    handler(.success(mostPopularMovies))
                } catch {
                    // Если произошла ошибка при декодировании JSON, возвращаем ошибку в обработчик
                    handler(.failure(error))
                }
            case .failure(let error):
                // Если произошла ошибка при загрузке данных, возвращаем ошибку в обработчик
                handler(.failure(error))
            }
        }
    }
}
