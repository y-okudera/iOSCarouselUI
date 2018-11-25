//
//  UIImageView+Nuke.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/25.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    
    func setImageByNuke(with url: URL) {
        
        image = nil
        let options = ImageLoadingOptions(failureImage: #imageLiteral(resourceName: "no_image"))
        Nuke.loadImage(with: url, options: options, into: self) { _, error in
            if let error = error {
                print(error)
            }
        }
    }
}
