//
//  DomainModel.swift
//  MVVMSample2
//
//  Created by taehy.k on 2021/08/01.
//

import Foundation

enum DomainStatus {
    case Available
    case Taken
    case Other
}

struct Domain {
    var domainName: String
    var domainStatus: DomainStatus
}

