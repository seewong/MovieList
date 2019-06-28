//
//  ListViewCell.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/27/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

public class ListViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func configureCell(movieListItem: MovieListItem) {
        self.titleLabel.text = movieListItem.title
        self.thumbnail.sd_setImage(with: URL(string: movieListItem.imageURL), placeholderImage: #imageLiteral(resourceName: "default-movie"))
    }
}
