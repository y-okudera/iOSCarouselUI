//
//  NibRegistrable.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

// MARK: - TableViewNibRegistrable
protocol TableViewNibRegistrable where Self: UITableViewCell {
    
    /// TableViewにNibを登録する
    ///
    /// - Parameter tableView: 登録先のTableView
    static func register(tableView: UITableView)
}

extension TableViewNibRegistrable {
    
    static func register(tableView: UITableView) {
        let nib = UINib(nibName: identifier, bundle: Bundle(for: self))
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}

// MARK: - CollectionViewNibRegistrable
protocol CollectionViewNibRegistrable where Self: UICollectionViewCell {
    
    /// CollectionViewにNibを登録する
    ///
    /// - Parameter collectionView: 登録先のCollectionView
    static func register(collectionView: UICollectionView)
}

extension CollectionViewNibRegistrable {
    
    static func register(collectionView: UICollectionView) {
        let nib = UINib(nibName: identifier, bundle: Bundle(for: self))
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
