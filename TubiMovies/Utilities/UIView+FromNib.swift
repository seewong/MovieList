//
//  UIView+FromNib.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/27/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public class func identifier() -> String {
        return String(describing: self)
    }

    public static func fromNib(withOwner owner: AnyObject! = nil) -> Self {
        return firstView(ofNibNamed: "\(self)", bundle: Bundle(for: self), owner: owner)
    }

    fileprivate static func firstView<T: UIView>(ofNibNamed nibName: String, bundle: Bundle, owner: AnyObject?) -> T {
        let nib = bundle.loadNibNamed(nibName, owner: owner, options: nil)
        guard let view = nib?.first as? T else {
            fatalError("No view found for nib named \(nibName)")
        }

        return view
    }
}
