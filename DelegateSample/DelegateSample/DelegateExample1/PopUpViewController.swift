//
//  PopUpViewController.swift
//  DelegateSample
//
//  Created by taehy.k on 2021/08/30.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var delegate: PopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goYoutubeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.openYoutubeWebView()
    }
    
    @IBAction func quitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
