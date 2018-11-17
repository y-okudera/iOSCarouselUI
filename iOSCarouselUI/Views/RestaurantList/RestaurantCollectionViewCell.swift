//
//  RestaurantCollectionViewCell.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

final class RestaurantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .systemFont(ofSize: UIFont.smallSystemFontSize)
        }
    }
}

extension RestaurantCollectionViewCell: CollectionViewNibRegistrable {}
