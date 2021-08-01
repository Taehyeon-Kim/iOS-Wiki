//
//  DomainViewModel.swift
//  MVVMSample2
//
//  Created by taehy.k on 2021/08/02.
//

import UIKit

class DomainViewModel: CellRepresentable {
    var domain: Domain
    var rowHeight: CGFloat = 60
    
    var status: String {
        switch domain.domainStatus {
        case .Available:
            return "Available"
        case .Taken:
            return ""
        case .Other:
            return ""
        }
    }
    
    init(domain: Domain) {
        self.domain = domain
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DomainTableViewCell", for: indexPath) as? DomainTableViewCell else {
            fatalError("no cell.")
        }
        
        cell.setup(vm: self)
        
        return cell
    }
}
