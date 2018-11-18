//
//  JSONFileReader.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

enum JSONFileReaderError: Error {
    case jsonFileNotFound
    case decodingError(Error)
    case others(Error)
}

final class JSONFileReader<T: Decodable>: InitializerInjectable {
    
    // MARK: - Initializer
    
    struct Dependency {
        let jsonFileName: String
        let decodeType: T.Type
    }
    
    init(dependency: JSONFileReader.Dependency) {
        self.jsonFileName = dependency.jsonFileName
        self.decodeType = dependency.decodeType
    }
    
    private var jsonFileName: String
    private var decodeType: T.Type
    
    /// JSONファイル名、Decodable Typeを指定してデコードする
    func decode(handler: (Result<T, JSONFileReaderError>) -> ()) {
        do {
            let name = jsonFileName.deletingPathExtension
            let type = jsonFileName.pathExtension
            let bundle = Bundle(for: JSONFileReader<T>.self)
            guard let jsonFilePath = bundle.path(forResource: name, ofType: type) else {
                handler(.failure(.jsonFileNotFound))
                return
            }
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
            let jsonData = try Data(contentsOf: jsonFileURL)
            
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(decodeType, from: jsonData)
            handler(.success(decodedObject))
            
        } catch let decodingError as DecodingError {
            print("[\(#function):\(#line)]decodingError: \(decodingError)")
            handler(.failure(.decodingError(decodingError)))
        } catch let error {
            print("[\(#function):\(#line)]error: \(error)")
            handler(.failure(.others(error)))
        }
    }
}
