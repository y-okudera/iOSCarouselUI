//
//  String+Path.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

extension String {
    
    private var ns: NSString {
        return (self as NSString)
    }
    
    /// 拡張子を取得する
    var pathExtension: String {
        return ns.pathExtension
    }
    
    /// 拡張子を削除する
    var deletingPathExtension: String {
        return ns.deletingPathExtension
    }
}
