//
//  ArticleService.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

import Foundation

import Alamofire
import RxSwift

// Protocol로써 타입을 관리하는 것이 재사용성과 확장성에 용이
protocol ArticleProtocol: AnyObject {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: ArticleProtocol {
    // Observable 형태로 서비스 코드를 작성했을 때 가장 좋다고 생각하는 부분이 콜백함수를 사용하지 않아도 된다는 점인 것 같다.
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            self.fetchNews { (error, articles) in
                
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    private func fetchNews(completion: @escaping ((Error?, [Article]?) -> ())) {
        
        let url = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=67ad21c648ec4b17afdec7294c8c3c45"
        
        guard let url = URL(string: url) else {
            return completion(NSError(domain: "taehyeon", code: 404, userInfo: nil), nil)
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
            .responseDecodable(of: ArticleResponse.self) { response in
                if let error = response.error {
                    completion(error, nil)
                }
                
                if let articles = response.value?.articles {
                    completion(nil, articles)
                }
            }
    }
    
}
