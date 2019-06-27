//
//  LoadingView.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/26/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import UIKit

public class LoadingView: UIView {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    public override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }
}
