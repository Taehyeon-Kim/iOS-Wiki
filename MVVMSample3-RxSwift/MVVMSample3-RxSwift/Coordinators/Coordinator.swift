//
//  Coordinator.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

/*
 규모가 작은 프로젝트에서는 굳이 Coordinator를 써야되나라는 생각이 듦
 */

import UIKit

class Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = RootViewController(rootViewModel: RootViewModel(articleService: ArticleService()))
        let navigationRootViewController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationRootViewController
        window.makeKeyAndVisible()
    }
}
