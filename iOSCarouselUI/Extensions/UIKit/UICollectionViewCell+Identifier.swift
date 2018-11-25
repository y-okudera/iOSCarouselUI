//
//  UICollectionViewCell+Identifier.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/25.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
}
