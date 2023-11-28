//
//  ArticleModel.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 22.03.23.
//

import Foundation

struct Response: Codable {
    var articles: [Article]
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
