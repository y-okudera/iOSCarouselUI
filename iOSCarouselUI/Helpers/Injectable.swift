//
//  Injectable.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

protocol InitializerInjectable {
    associatedtype Dependency
    init(dependency: Dependency)
}

protocol MethodInjectable {
    associatedtype Dependency
    func inject(dependency: Dependency)
}
