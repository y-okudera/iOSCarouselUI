//
//  RestaurantListViewController.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit
import Nuke

/// 飲食店一覧画面
final class RestaurantListViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    
    private let sectionHeaderHeight: CGFloat = 44.0
    private var jsonFileReader: JSONFileReader<[Restaurant]>!
    private var rests: [Restaurant]!
    
    private var offsetsDic = [String: NSNumber]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        RestaurantListCell.register(tableView: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readRestaurantData()
    }
    
    private func readRestaurantData() {
        jsonFileReader.decode { result in
            
            switch result {
            case .success(let restaurantsData):
                self.rests = restaurantsData
                tableView.reloadData()
                
            case .failure(let error):
                print(error)
                let errorMSG = "restaurants_info_read_failure".localized()
                showAlert(title: "error".localized(), message: errorMSG)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension RestaurantListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rests.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantListCell.identifier,
            for: indexPath) as! RestaurantListCell
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.section
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RestaurantListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RestaurantTableHeaderView(
            frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: sectionHeaderHeight)
        )
        headerView.titleLabel.text = rests[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        let restaurantCell = cell as! RestaurantListCell
        let tag = restaurantCell.collectionView.tag
        
        guard let horizontalOffsetNum = offsetsDic["\(tag)"] else {
            return
        }
        let horizontalOffset = CGFloat(truncating: horizontalOffsetNum)
        restaurantCell.collectionView.contentOffset = CGPoint(x: horizontalOffset, y: 0)
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        let restaurantCell = cell as! RestaurantListCell
        let horizontalOffset = restaurantCell.collectionView.contentOffset.x
        let horizontalOffsetNum = NSNumber(value: Float(horizontalOffset))
        let tag = restaurantCell.collectionView.tag
        offsetsDic["\(tag)"] = horizontalOffsetNum
    }
}

// MARK: - UICollectionViewDataSource
extension RestaurantListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return rests[collectionView.tag].shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RestaurantCollectionViewCell.identifier,
            for: indexPath) as! RestaurantCollectionViewCell
        
        cell.nameLabel.text = rests[collectionView.tag].shops[indexPath.row].name
        
        cell.imageView.image = nil
        cell.imageView.isHidden = false
        if let url = URL(string: rests[collectionView.tag].shops[indexPath.row].shop_image1) {
            Nuke.loadImage(with: url, into: cell.imageView) { _, error in
                if let error = error {
                    print(error)
                    cell.imageView.isHidden = true
                }
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RestaurantListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = collectionView.frame.height
        let itemSize = CGSize(width: itemHeight * 0.5, height: itemHeight)
        return itemSize
    }
}

// MARK: - ViewControllerInstantiatable
extension RestaurantListViewController: ViewControllerInstantiatable {}

// MARK: - MethodInjectable
extension RestaurantListViewController: MethodInjectable {
    
    struct Dependency {
        let jsonFileReader: JSONFileReader<[Restaurant]>
        let rests: [Restaurant]
    }
    
    func inject(dependency: RestaurantListViewController.Dependency) {
        self.jsonFileReader = dependency.jsonFileReader
        self.rests = dependency.rests
    }
}
