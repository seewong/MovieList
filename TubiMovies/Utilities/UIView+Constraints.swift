//
//  UIView+Constraints.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// Align the views frame to the superview view
    func constraints_matchSuperview() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `constraints_matchSuperview()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false

        superview.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|",
                                           options: NSLayoutConstraint.FormatOptions(),
                                           metrics: nil,
                                           views: ["subview": self]
            )
        )

        superview.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|",
                                           options: NSLayoutConstraint.FormatOptions(),
                                           metrics: nil,
                                           views: ["subview": self]))
    }
}
