//
//  UICollectionView+CellCastable.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/25.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
