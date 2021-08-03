//
//  RootViewModel.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

import Foundation

import RxSwift

// final 키워드를 사용하는 이유?
final class RootViewModel {
    let title = "News"
    
    private let articleService: ArticleProtocol
    
    init(articleService: ArticleProtocol) {
        self.articleService = articleService
    }
    
    func fetchNews() -> Observable<[ArticleViewModel]> {
        articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0)} }
    }
}
