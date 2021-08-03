//
//  ArticleViewModel.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

import Foundation

struct ArticleViewModel {
    private let article: Article
    
    var imageUrl: String? {
        return article.urlToImage
    }
    
    var title: String? {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
