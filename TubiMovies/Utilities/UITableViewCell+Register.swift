//
//  UITableViewCell+Register.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/27/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    public class func registerForTableView(_ tableView: UITableView) {
        let identifier = String(describing: self)
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: identifier, bundle: bundle)

        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}
