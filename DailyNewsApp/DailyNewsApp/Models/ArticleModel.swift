//
//  ArticleModel.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 22.03.23.
//

import Foundation

struct Response: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let published: String?
}

struct Source: Codable {
    let name: String
}

final class ApiCaller {

//     static let shared = ApiCaller()

     struct Constants {
         static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=56324ef9df0e4701a46b0b30ba67448b")
         static let searchURL = "https://newsapi.org/v2/everything?sortedBy=popularuty&apiKey=56324ef9df0e4701a46b0b30ba67448b&q="
         static let entUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=56324ef9df0e4701a46b0b30ba67448b")
         static let businessURl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=56324ef9df0e4701a46b0b30ba67448b")
         static let healthURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=56324ef9df0e4701a46b0b30ba67448b")
         static let scienceURl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=56324ef9df0e4701a46b0b30ba67448b")
         static let sportURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=sport&apiKey=56324ef9df0e4701a46b0b30ba67448b")
         static let techUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=56324ef9df0e4701a46b0b30ba67448b")
     }

     private init() {}

     static func fetchArticles(completion: @escaping(Result<[Article], Error>) -> Void) {
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
    
    static func search(with query: String, completion: @escaping(Result<[Article], Error>) -> Void) {
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
    
    static func fetchEntArticles(completion: @escaping(Result<[Article], Error>) -> Void) {
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
    
    static func fetchBusinessArticles(completion: @escaping(Result<[Article], Error>) -> Void) {
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
    
    static func fetchHealthArticles(completion: @escaping(Result<[Article], Error>) -> Void) {
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
    
    static func fetchScienceArticles(completion: @escaping(Result<[Article], Error>) -> Void) {
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
    
    static func fetchSportArticles(completion: @escaping(Result<[Article], Error>) -> Void) {
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
    
    static func fetchTechArticles(completion: @escaping(Result<[Article], Error>) -> Void) {
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
