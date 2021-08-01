//
//  CellRepresentable.swift
//  MVVMSample2
//
//  Created by taehy.k on 2021/08/01.
//

import UIKit

protocol CellRepresentable {
    var rowHeight: CGFloat { get }
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
