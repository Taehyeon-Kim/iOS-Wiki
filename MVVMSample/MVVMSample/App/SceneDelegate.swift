//
//  SceneDelegate.swift
//  MVVMSample
//
//  Created by taehy.k on 2021/07/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let newsVC = UIStoryboard(name: "NewsStoryboard", bundle: nil).instantiateViewController(identifier: "NewsViewController") as? NewsViewController else { return }
        window?.rootViewController = UINavigationController(rootViewController: newsVC)
        window?.makeKeyAndVisible()
    }
}

