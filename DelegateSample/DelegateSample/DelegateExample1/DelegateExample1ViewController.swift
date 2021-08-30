//
//  DelegateExample1ViewController.swift
//  DelegateSample
//
//  Created by taehy.k on 2021/08/30.
//

import UIKit

import WebKit

class DelegateExample1ViewController: UIViewController, PopUpDelegate {
    
    private let webView = WKWebView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
    }
    
    @IBAction func openPopupTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PopUpViewController")
                as? PopUpViewController else { return }
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    private func setWebView() {
        webView.frame = view.bounds
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(webView, at: 0)
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func executeWebView() {
        let url = URL(string: "https://www.youtube.com/watch?v=Rxf79B69lOo")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func openYoutubeWebView() {
        navigationController?.navigationBar.isHidden = true
        print("open Youtube")
        executeWebView()
    }
}
