//
//  Restaurant.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

struct Restaurant: Codable {
    var title: String
    let shops: [Shop]
}

struct Shop: Codable {
    var name = ""
    var address = ""
    var tel = ""
    var budget = ""
    var shop_image1 = ""
}
