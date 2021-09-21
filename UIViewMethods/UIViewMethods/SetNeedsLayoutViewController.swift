//
//  SetNeedsLayoutViewController.swift
//  UIViewMethods
//
//  Created by taehy.k on 2021/09/21.
//

import UIKit

class SetNeedsLayoutViewController: UIViewController {
    
    // MARK: - Properties
    
    var isExpanded: Bool = false

    // MARK: - UI Properties
    
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction private func actButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            if self?.isExpanded == true {
                self?.collapseView()
                self?.isExpanded = false
            } else {
                self?.expandView()
                self?.isExpanded = true
            }
        }
    }
    
    private func expandView() {
        heightConstraint.constant = 100
        view.setNeedsLayout()
    }
    
    private func collapseView() {
        heightConstraint.constant = 50
        view.setNeedsLayout()
    }
}
