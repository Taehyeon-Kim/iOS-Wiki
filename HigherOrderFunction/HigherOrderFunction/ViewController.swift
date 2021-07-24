//
//  ViewController.swift
//  HigherOrderFunction
//
//  Created by taehy.k on 2021/07/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let numbers: [Int] = [1, 2, 3, 4, 5, 6, 7, 8]
    let arrayWithNil = [1, nil, 3, 4, nil, 6, nil, 8]
    let twoDimensionalArrayWithNil = [[1, 2, 3], [nil, 5], [6, nil], [nil, nil]]

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func mapButtonTapped(_ sender: Any) {
        executeMap()
    }
    
    @IBAction func reduceButtonTapped(_ sender: Any) {
        executeReduce()
    }
    
    @IBAction private func filterButtonTapped(_ sender: UIButton) {
        executeFilter()
    }
    
    @IBAction private func compactMapTapped(_ sender: Any) {
        executeCompactMap()
    }
    
    @IBAction func flatMapTapped(_ sender: Any) {
        executeFlatMap()
    }
}

// MARK: - Custom Functions
extension ViewController {
    // Mark: - Map
    // - 특정 형태로 변환해서 요소를 반환
    private func executeMap() {
        let doubledNumbers = numbers.map { $0 * 2 }
        print(doubledNumbers)
    }
    // Mark: - Reduce
    // - 초기원소를 지정해주고, 나머지 요소를 합쳐서 반환
    private func executeReduce() {
        let sum = numbers.reduce(0) { $0 + $1 }
        print(sum)
    }
    // Mark: - Filter
    // - 조건을 걸어주고 True인 요소 반환
    private func executeFilter() {
        let even = numbers.filter { $0 % 2 == 0 }
        print(even)
    }
    // Mark: - CompactMap
    // - 배열에 nil 값이 있는 경우, 제외하고 요소 반환
    private func executeCompactMap() {
        let compactMapArray = arrayWithNil.compactMap { $0 }
        print(compactMapArray)
    }
    // Mark: - FlatMap
    // - 2차원 배열을 1차원 배열로 변환
    // - nil값 제거 위해서는 compactMap 사용
    // - flatMap, CompactMap은 1차원배열일때만 nil값 제거
    private func executeFlatMap() {
        let flatMapArray = twoDimensionalArrayWithNil
            .flatMap { $0 }
            .compactMap { $0 }
        print(flatMapArray)
    }
}
