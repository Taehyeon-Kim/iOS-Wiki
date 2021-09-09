//
//  CartDelegate.swift
//  DelegatePattern
//
//  Created by taehy.k on 2021/09/09.
//

import Foundation

protocol CartDelegate {
    func alarmCartIsFilled(itemCount: Int)
}
