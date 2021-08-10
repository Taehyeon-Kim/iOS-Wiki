//
//  ViewController.swift
//  CustomViewSample
//
//  Created by taehy.k on 2021/08/08.
//

import UIKit

class ViewController: UIViewController {

    let stackView = UIStackView()
    let button1 = CustomButton(backgroundColor: .systemRed, title: "아니오")
    let button2 = CustomButton(backgroundColor: .systemGreen, title: "네")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    private func setup() {
        view.addSubviews(stackView)
        stackView.addArrangedSubviews(button1, button2)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        _ = views.map {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
