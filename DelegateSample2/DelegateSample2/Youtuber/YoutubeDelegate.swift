//
//  YoutubeDelegate.swift
//  DelegateSample2
//
//  Created by taehy.k on 2021/09/03.
//

import Foundation

protocol YoutubeDelegate: AnyObject {
    func youtubeTableViewCell(_ tableViewCell: YoutubeTableViewCell, youtuber: String)
}
