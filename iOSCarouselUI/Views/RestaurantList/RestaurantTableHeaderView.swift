//
//  RestaurantTableHeaderView.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/18.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

final class RestaurantTableHeaderView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .boldSystemFont(ofSize: UIFont.labelFontSize)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
}

extension RestaurantTableHeaderView: NibLoadable {}
