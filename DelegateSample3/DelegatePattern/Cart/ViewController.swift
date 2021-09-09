//
//  ViewController.swift
//  DelegatePattern
//
//  Created by taehy.k on 2021/09/09.
//

import UIKit

class ViewController: UIViewController, CartDelegate {

    @IBOutlet weak private var productNameLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func alarmCartIsFilled(itemCount: Int) {
        let alertVC = UIAlertController(title: "장바구니 확인", message: "장바구니에 \(itemCount)개의 상품이 추가되었습니다.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func cartButtonTapped() {
        let cartVC = storyboard?.instantiateViewController(identifier: "CartViewController") as! CartViewController
        cartVC.delegate = self // cartVC의 권한은 내가 대신할거야
        
        if let productName = productNameLabel.text,
           let price = priceLabel.text {
            cartVC.productName = productName
            cartVC.price = price
        }
        present(cartVC, animated: true, completion: nil)
    }
}

