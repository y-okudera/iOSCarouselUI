//
//  RestaurantListCell.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

final class RestaurantListCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RestaurantCollectionViewCell.register(collectionView: collectionView)
    }    
}

extension RestaurantListCell: TableViewNibRegistrable {}
