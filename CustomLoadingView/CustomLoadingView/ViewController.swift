//
//  ViewController.swift
//  CustomLoadingView
//
//  Created by taehy.k on 2021/01/13.
//

import UIKit

class ViewController: UIViewController {
    
    private var loadingView: LoadingView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadingView()
    }
    
    func setLoadingView() {
        let loadingViewFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingView = LoadingView(frame: loadingViewFrame)
        guard let loading = loadingView else { return }
        
        loading.center = self.view.center
        loading.startAnimation()
        self.view.addSubview(loading)
    }


}

