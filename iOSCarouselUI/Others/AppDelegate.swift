//
//  AppDelegate.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]?
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: LaunchOptions) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = appRootViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func appRootViewController() -> UIViewController {
        let jsonFileReaderDependency = JSONFileReader.Dependency(
            jsonFileName: "rest01.json",
            decodeType: [Restaurant].self
        )
        let jsonFileReader = JSONFileReader(dependency: jsonFileReaderDependency)
        
        return ViewControllerBuilder<RestaurantListViewController>.build(
            dependency: RestaurantListViewController.Dependency(
                jsonFileReader: jsonFileReader,
                rests: [Restaurant]()
            )
        )
    }
}
