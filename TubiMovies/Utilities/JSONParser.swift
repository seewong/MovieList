//
//  JSONParser.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/25/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation

public class JSONParser {
    static let shared = JSONParser()

    public func parse<T>(data: Data?, type: T.Type) -> T? where T: Decodable {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        do {
            let obj = try decoder.decode(type, from: data)
            return obj
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
