//
//  ViewController.swift
//  FrameBoundsSample
//
//  Created by taehy.k on 2021/08/20.
//

import UIKit

class ViewController: UIViewController {
    
    let grayView = UIView()
    let orangeView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        grayView.backgroundColor = .gray
        grayView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        view.addSubview(grayView)
        
        orangeView.backgroundColor = .orange
        orangeView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        grayView.addSubview(orangeView)
        
        UIView.animate(withDuration: 2) {
            // code
            // 주황색 박스를 회색 박스의 우측하단으로 보내는 코드를 작성하시오.
            self.grayView.bounds.origin.x = -100
            self.grayView.bounds.origin.y = -100
        }
        
        print("========= Frame ==========")
        print("redView frame: ", grayView.frame.origin, grayView.frame.size)
        print("greenView frame: ", orangeView.frame.origin, orangeView.frame.size)
        
        print("========= Bounds ==========")
        print("redView bounds: ", grayView.bounds.origin, grayView.bounds.size)
        print("greenView bounds: ", orangeView.bounds.origin, orangeView.bounds.size)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let navigationController = UINavigationController(rootViewController: ViewController())
            navigationController.navigationBar.prefersLargeTitles = true
            return navigationController
        }
    }
}
#endif
