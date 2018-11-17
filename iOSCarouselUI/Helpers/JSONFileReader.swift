//
//  JSONFileReader.swift
//  iOSCarouselUI
//
//  Created by YukiOkudera on 2018/11/17.
//  Copyright © 2018 Yuki Okudera. All rights reserved.
//

import Foundation

final class JSONFileReader {
    
    /// JSONファイル名、Decodable Typeを指定してデコードする
    static func decode<T: Decodable>(jsonFileName: String,
                                     type: T.Type,
                                     handler: (Result<T, Error?>) -> ()) {
        do {
            guard let jsonData = try JSONFileReader.read(fileName: jsonFileName) else {
                handler(.failure(nil))
                return
            }
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(type, from: jsonData)
            handler(.success(decodedObject))
            
        } catch let e {
            handler(.failure(e))
        }
    }
    
    /// JSONファイル名を指定して、データを取得する
    ///
    /// - Parameter fileName: e.g. "area.json"
    /// - Returns: main bundleに対象ファイルが存在しない場合: nil, 存在する場合: Data
    /// - Throws: urlが読み込めない場合に発生するエラー
    private static func read(fileName: String) throws -> Data? {
        
        let name = fileName.deletingPathExtension
        let type = fileName.pathExtension
        let bundle = Bundle(for: self)
        guard let jsonFilePath = bundle.path(forResource: name, ofType: type) else {
            return nil
        }
        
        let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
        return try Data(contentsOf: jsonFileURL)
    }
}
