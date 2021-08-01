//
//  ProductViewModel.swift
//  MVVMSample2
//
//  Created by taehy.k on 2021/08/02.
//

import UIKit

class ProductViewModel: CellRepresentable {
    var product: Product
    var rowHeight: CGFloat = 100
    
    var price: String {
        guard let price = product.price else {
            return "free"
        }
        
        return "$\(price)"
    }
    
    init(product: Product) {
        self.product = product
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        
        // Pass ourselves (the view model) to setup the cell
        cell.setup(vm: self)
       
        // Return the cell
        return cell
    }
}
