//
//  NewsData.swift
//  News-App
//
//  Created by Edo Lorenza on 18/05/21.
//

import Foundation

struct NewsData: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

struct Articles: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let sources: Sources?
}

struct Sources: Codable {
    let name: String
}

