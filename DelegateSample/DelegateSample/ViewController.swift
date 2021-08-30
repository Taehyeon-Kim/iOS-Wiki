//
//  ViewController.swift
//  DelegateSample
//
//  Created by taehy.k on 2021/08/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func delegateExampleButton1Tapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "DelegateExample1ViewController") as? DelegateExample1ViewController else {
            print("No Storyboard")
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

