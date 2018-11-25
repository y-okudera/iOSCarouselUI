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
    
    func setViewData(delegator: UICollectionViewDataSource & UICollectionViewDelegate, tag: Int) {
        collectionView.dataSource = delegator
        collectionView.delegate = delegator
        collectionView.tag = tag
        collectionView.reloadData()
    }
}

extension RestaurantListCell: TableViewNibRegistrable {}
