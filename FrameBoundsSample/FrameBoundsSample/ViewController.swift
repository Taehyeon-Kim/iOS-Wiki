//
//  ViewController.swift
//  FrameBoundsSample
//
//  Created by taehy.k on 2021/08/20.
//

import UIKit

class ViewController: UIViewController {
    
    let redView = UIView()
    let greenView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        redView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        greenView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        UIView.animate(withDuration: 2) {
            self.redView.bounds = CGRect(x: -50, y: -50, width: self.redView.frame.width, height: self.redView.frame.height)
        }
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        
        view.addSubview(redView)
        redView.addSubview(greenView)
        
        print("========= Frame ==========")
        print("redView frame: ", redView.frame.origin, redView.frame.size)
        print("greenView frame: ", greenView.frame.origin, greenView.frame.size)
        
        print("========= Bounds ==========")
        print("redView bounds: ", redView.bounds.origin, redView.bounds.size)
        print("greenView bounds: ", greenView.bounds.origin, greenView.bounds.size)
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
