//
//  DetailViewController.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    let viewModel: DetailViewModel
    let loadingView = LoadingView.fromNib()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!

    init(id: String,
         networkingService: NetworkingServiceType = NetworkingService()) {
        self.viewModel = DetailViewModel(id: id, networkingService: networkingService)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Description"
        viewModel.delegate = self
        viewModel.loadMovie()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func networkState(state: NetworkState) {
        switch state {
        case .loading:
            self.view.addSubview(loadingView)
            loadingView.constraints_matchSuperview()
        case .loaded:
            loadingView.removeFromSuperview()
            guard let movie = viewModel.movie else { return }
            self.titleLabel.text = movie.title
            self.imageView.sd_setImage(with: URL(string: movie.imageURL), placeholderImage: #imageLiteral(resourceName: "default-movie"))
            if let index = movie.index {
                self.bottomLabel.text = "Index: " + String(index)
            }
        case .error:
            print("error")
        }
    }
}
