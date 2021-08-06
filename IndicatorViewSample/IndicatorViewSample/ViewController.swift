//
//  ViewController.swift
//  IndicatorViewSample
//
//  Created by taehy.k on 2021/08/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.displayAnimatedActivityIndicatorView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let `self` = self else { return }
            self.view.hideAnimatedActivityIndicatorView()
        }
    }
}

