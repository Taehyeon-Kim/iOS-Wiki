//
//  UITableView+.swift
//  MVVMSample
//
//  Created by taehy.k on 2021/07/30.
//

import UIKit

extension UITableView {
    // Dequeue Cell
    // 타입 캐스팅 해주었는데 뷰컨트롤러에서 타입 명시 안해주면 사용을 못한다.
    // 이유 파악 후 코드 수정 필요
    func cell<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("no cell")
        }
        return cell
    }
}
