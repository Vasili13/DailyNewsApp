//
//  NetworkService.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 5.04.23.
//

import Foundation

final class NetworkService {
    
    //fetch top headlines articles
    static func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    //fetch article for searching
    static func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let urlString = Constants.searchURL + query

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
    //fetch entartainment articles
    static func fetchEntArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.entUrl else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    //fetch business articles
    static func fetchBusinessArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.businessURl else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    //fetch health articles
    static func fetchHealthArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.healthURL else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    //fetch science articles
    static func fetchScienceArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.scienceURl else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    //fetch science articles
    static func fetchSportArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.sportURL else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    //fetch technology articles
    static func fetchTechArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.techUrl else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
