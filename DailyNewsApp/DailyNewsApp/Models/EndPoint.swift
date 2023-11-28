//
//  Constant.swift
//  DailyNewsApp
//
//  Created by Василий Вырвич on 5.04.23.
//

import Foundation

enum Endpoint: String {
    case topHeadlines
    case entHeadlines
    case businessHeadlines
    case healthHeadlines
    case scienceHeadlines
    case sportHeadlines
    case techHeadlines
    case searchHeadline = "https://newsapi.org/v2/everything?sortedBy=popularuty&apiKey=56324ef9df0e4701a46b0b30ba67448b&q="
    
    var url: String {
        switch self {
        case .topHeadlines:
            "https://newsapi.org/v2/top-headlines?country=us&apiKey=56324ef9df0e4701a46b0b30ba67448b"
        case .entHeadlines:
            "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=56324ef9df0e4701a46b0b30ba67448b"
        case .businessHeadlines:
            "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=56324ef9df0e4701a46b0b30ba67448b"
        case .healthHeadlines:
            "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=56324ef9df0e4701a46b0b30ba67448b"
        case .scienceHeadlines:
            "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=56324ef9df0e4701a46b0b30ba67448b"
        case .sportHeadlines:
            "https://newsapi.org/v2/top-headlines?country=us&category=sport&apiKey=56324ef9df0e4701a46b0b30ba67448b"
        case .techHeadlines:
            "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=56324ef9df0e4701a46b0b30ba67448b"
        case .searchHeadline:
            "https://newsapi.org/v2/everything?sortedBy=popularuty&apiKey=56324ef9df0e4701a46b0b30ba67448b&q="
        }
    }
}
