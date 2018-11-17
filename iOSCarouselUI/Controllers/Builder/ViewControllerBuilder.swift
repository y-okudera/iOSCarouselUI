//
//  ViewControllerBuilder.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

struct ViewControllerBuilder<T: ViewControllerInstantiatable & MethodInjectable> {
    
    static func build(dependency: T.Dependency) -> T {
        let viewController = T.instantiate()
        viewController.inject(dependency: dependency)
        return viewController
    }
}
