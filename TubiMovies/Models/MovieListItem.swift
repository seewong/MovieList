//
//  MovieListItem.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/25/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation

public struct MovieListItem: Codable {
    let title: String
    let imageURL: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image"
        case id
    }
}
