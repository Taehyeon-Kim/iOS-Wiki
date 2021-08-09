//
//  Alert.swift
//  ErrorHandling
//
//  Created by taehy.k on 2021/08/09.
//

import UIKit

class Alert {
    
    class func showBasic(title: String,
                         message: String,
                         vc: UIViewController)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
}
