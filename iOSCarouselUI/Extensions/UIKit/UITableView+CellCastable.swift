//
//  UITableView+CellCastable.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/25.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
