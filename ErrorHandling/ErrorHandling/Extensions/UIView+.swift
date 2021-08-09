//
//  UIView+.swift
//  ErrorHandling
//
//  Created by taehy.k on 2021/08/09.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        _ = views.map {
            addSubview($0)
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
