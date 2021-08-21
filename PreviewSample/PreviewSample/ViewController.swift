//
//  ViewController.swift
//  PreviewSample
//
//  Created by taehy.k on 2021/08/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UI Properties
    
    private let redView: UIView = {
        let view = UIView()
        view.frame = .zero
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let greenView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeViewController()
        setupSquare()
    }
}

// MARK: - Helpers

extension ViewController {
    func makeViewController() {
        title = "Title"
    }
    
    func setupSquare() {
        view.addSubview(redView)
        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        redView.addSubview(greenView)
        redView.bounds.origin.x = -50
        redView.bounds.origin.y = -50
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct Preview: PreviewProvider{
    static var previews: some View {
        // MARK: NavigationViewController를 나타내려면 다음과 같이 직접 가져와야 함
        UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "MainNavigationViewController")
            .showPreview(.iPhone12)
            .previewLayout(.sizeThatFits)
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
