//
//  NetworkService.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 5.04.23.
//

import Foundation

final class NetworkService {

    //fetch article for searching
    static func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let urlString = Endpoint.searchHeadline.rawValue + query
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
}
