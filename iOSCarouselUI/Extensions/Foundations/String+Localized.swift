//
//  String+Localized.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

extension String {
    
    /// selfをキーとしてLocalizable.stringsで定義した文字列を取得する
    func localized() -> String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
}
