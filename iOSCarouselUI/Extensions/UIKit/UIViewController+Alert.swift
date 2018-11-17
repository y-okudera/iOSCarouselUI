//
//  UIViewController+Alert.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: handler)
        )
        present(alert, animated: true, completion: nil)
    }
}
