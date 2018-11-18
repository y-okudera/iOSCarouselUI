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
    
    static var identifier: String { get }
    
    /// TableViewにNibを登録する
    ///
    /// - Parameter tableView: 登録先のTableView
    static func register(tableView: UITableView)
}

extension TableViewNibRegistrable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func register(tableView: UITableView) {
        tableView.register(
            UINib(nibName: identifier, bundle: Bundle(for: self)),
            forCellReuseIdentifier: identifier
        )
    }
}

// MARK: - CollectionViewNibRegistrable
protocol CollectionViewNibRegistrable where Self: UICollectionViewCell {
    
    static var identifier: String { get }
    
    /// CollectionViewにNibを登録する
    ///
    /// - Parameter collectionView: 登録先のCollectionView
    static func register(collectionView: UICollectionView)
}

extension CollectionViewNibRegistrable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func register(collectionView: UICollectionView) {
        collectionView.register(
            UINib(nibName: identifier, bundle: Bundle(for: self)),
            forCellWithReuseIdentifier: identifier
        )
    }
}
