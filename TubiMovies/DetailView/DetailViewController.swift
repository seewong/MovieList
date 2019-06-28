//
//  DetailViewController.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    let viewModel: DetailViewModel
    let loadingView = LoadingView.fromNib()

    init(id: String, title: String) {
        self.viewModel = DetailViewModel(id: id)
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
            print("loaded")
        case .error:
            print("error")
        }
    }
}
