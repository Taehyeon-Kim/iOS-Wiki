//
//  Article.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]?
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
}
