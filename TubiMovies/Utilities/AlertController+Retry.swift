//
//  AlertController+Retry.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func tryAgainAlert(title: String, message: String, tryAgainHandler: (@escaping () -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let tryAgainTitle = "Try again"
        let tryAgainAction = UIAlertAction(title: tryAgainTitle, style: .default, handler: { _ in tryAgainHandler() })
        alertController.addAction(tryAgainAction)

        let cancelTitle = "Cancel"
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        return alertController
    }
}
