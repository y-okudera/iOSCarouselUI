//
//  RestaurantListService.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

enum RestaurantListServiceError: Error {
    case failedToReadJSON
    case decodingErrorOccurred(Error)
    case errorOccurred(Error)
}

struct RestaurantListService<T: Decodable>: InitializerInjectable {
    
    // MARK: - Initializer
    
    struct Dependency {
        let jsonFileName: String
        let decodeType: T.Type
    }
    
    init(dependency: RestaurantListService.Dependency) {
        self.jsonFileName = dependency.jsonFileName
        self.decodeType = dependency.decodeType
    }
    
    private var jsonFileName: String
    private var decodeType: T.Type
    
    /// ローカルのjsonファイルから情報を取得する
    func readRestaurantData(handler: (Result<T, RestaurantListServiceError>) -> ()) {
        
        JSONFileReader.decode(jsonFileName: self.jsonFileName, type: self.decodeType) { result in
            switch result {
            case .success(let decodedObject):
                handler(Result.success(decodedObject))
                
            case .failure(let error):
                guard let error = error else {
                    handler(.failure(.failedToReadJSON))
                    return
                }
                if error is DecodingError {
                    handler(.failure(.decodingErrorOccurred(error)))
                    return
                }
                handler(.failure(.errorOccurred(error)))
            }
        }
    }
}
