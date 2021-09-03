//
//  ViewController.swift
//  DelegateSample2
//
//  Created by taehy.k on 2021/09/03.
//

import UIKit

class ViewController: UIViewController {
    // MARK - Properties
    let youtubers = ["Brian Voong", "Seth Everman", "Dave Lee", "Cybershell", "Bill Wurtz"]

    // MARK: - UI Properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - TableView Extension

typealias UITableViewMethods = UITableViewDataSource & UITableViewDelegate

extension ViewController: UITableViewMethods {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        youtubers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YoutubeTableViewCell.cellId, for: indexPath) as? YoutubeTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.configureCell(youtuber: youtubers[indexPath.row])
        return cell
    }
}

// MARK: - Youtube Delegate
extension ViewController: YoutubeDelegate {
    func youtubeTableViewCell(_ tableViewCell: YoutubeTableViewCell, youtuber: String) {
        let message = "\(youtuber)님을 구독하시겠습니까?"
        let alertVC = UIAlertController(title: "Subscribe", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}
