//
//  RestaurantListViewController.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

/// 飲食店一覧画面
final class RestaurantListViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    
    private let sectionHeaderHeight: CGFloat = 44.0
    private var jsonFileReader: JSONFileReader<[Restaurant]>!
    private var rests: [Restaurant]!
    private var offsets: [String: CGFloat]!
    
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

// MARK: - UIScrollViewDelegate
extension RestaurantListViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView else {
            return
        }
        
        let visibleRestaurantCells = tableView.visibleCells.map {
            $0 as! RestaurantListCell
        }
        
        for visibleCell in visibleRestaurantCells {
            let tag = visibleCell.collectionView.tag
            offsets["\(tag)"] = visibleCell.collectionView.contentOffset.x
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
        let cell: RestaurantListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setViewData(delegator: self, tag: indexPath.section)
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
        
        guard let horizontalOffset = offsets["\(tag)"] else {
            restaurantCell.collectionView.contentOffset = .zero
            return
        }
        restaurantCell.collectionView.contentOffset = CGPoint(x: horizontalOffset, y: 0)
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
        
        let cell: RestaurantCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setViewData(
            name: rests[collectionView.tag].shops[indexPath.row].name,
            imageURLString: rests[collectionView.tag].shops[indexPath.row].shop_image1
        )
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
        let offsets: [String: CGFloat]
    }
    
    func inject(dependency: RestaurantListViewController.Dependency) {
        self.jsonFileReader = dependency.jsonFileReader
        self.rests = dependency.rests
        self.offsets = dependency.offsets
    }
}
