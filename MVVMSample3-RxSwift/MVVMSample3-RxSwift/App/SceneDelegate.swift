//
//  SceneDelegate.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if let window = self.window {
            let coordinator = Coordinator(window: window)
            coordinator.start()
        } else {
            fatalError()
        }
    }
}
