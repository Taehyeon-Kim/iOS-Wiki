//
//  Article.swift
//  MVVMSample
//
//  Created by taehy.k on 2021/07/30.
//

import Foundation

struct ArticleList: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
}
