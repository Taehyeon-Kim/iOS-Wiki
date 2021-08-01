//
//  DomainTableViewCell.swift
//  MVVMSample2
//
//  Created by taehy.k on 2021/08/02.
//

import UIKit

class DomainTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(vm: DomainViewModel) {
        textLabel?.text = vm.domain.domainName
        detailTextLabel?.text = vm.status
    }
}
