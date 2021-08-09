//
//  CustomTextField.swift
//  ErrorHandling
//
//  Created by taehy.k on 2021/08/09.
//

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    private func configure() {
        addLeftPadding(10)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 10
        borderStyle = .none
        textColor = .black
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITextField {
    func addLeftPadding(_ leftPadding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
