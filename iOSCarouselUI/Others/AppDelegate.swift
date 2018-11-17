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
        let vc = ViewControllerBuilder<RestaurantListViewController>.build(
            dependency: RestaurantListViewController.Dependency(service: nil, rests: [Restaurant]())
        )
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
        return true
    }
}
