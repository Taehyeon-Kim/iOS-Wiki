//
//  ViewController.swift
//  TableViewDeleteFunction
//
//  Created by taehy.k on 2021/09/19.
//

import UIKit

// MARK: - Data Model
struct DummyModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

// MARK: - Controller
class ViewController: UIViewController {
    // MARK: - Properties
    private var dummyData: [[DummyModel]] = []

    // MARK:- UI Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setDummy()
    }
    
    // MARK: - Set Functions
    /// 테이블뷰 셋업
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// 더미 셋업
    private func setDummy() {
        dummyData.append(contentsOf: [
            [
                DummyModel(title: "1section-1"),
                DummyModel(title: "1section-2"),
                DummyModel(title: "1section-3"),
                DummyModel(title: "1section-4")
            ],
            [
                DummyModel(title: "2section-1"),
                DummyModel(title: "2section-2"),
                DummyModel(title: "2section-3"),
                DummyModel(title: "2section-4")
            ],
        ])
    }
}

// MARK: - TableView
typealias TableViewMethods = UITableViewDelegate & UITableViewDataSource

extension ViewController: TableViewMethods {
    /// 섹션수와 섹션에 따른 행의 갯수를 잘 지정해준다.
    func numberOfSections(in tableView: UITableView) -> Int {
        dummyData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = dummyData[indexPath.section][indexPath.row].title
        return cell
    }
    
    /// Delete Function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dummyData[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
