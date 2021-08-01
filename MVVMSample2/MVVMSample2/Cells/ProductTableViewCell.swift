//
//  ProductTableViewCell.swift
//  MVVMSample2
//
//  Created by taehy.k on 2021/08/02.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(vm: ProductViewModel) {
        self.textLabel?.text = vm.product.name
        self.detailTextLabel?.text = vm.price
    }
}
