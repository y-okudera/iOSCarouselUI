//
//  Result.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}
