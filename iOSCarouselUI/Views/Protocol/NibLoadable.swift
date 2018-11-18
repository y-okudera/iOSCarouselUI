//
//  NibLoadable.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/18.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

protocol NibLoadable where Self: UIView {
    func loadNib()
}

extension NibLoadable {
    
    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        if let view = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
