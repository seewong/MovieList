//
//  ViewController.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/24/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import UIKit

public enum NetworkState {
    case loading
    case loaded
    case error
}

class ListViewController: UITableViewController {
    let viewModel: ListViewModel
    let loadingView = LoadingView.fromNib()

    init() {
        self.viewModel = ListViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewModel()

        loadMovies()
    }

    func configureTableView() {
        //To get rid of trailing hairlines
        tableView.tableFooterView = UIView()
    }

    func configureViewModel() {
        viewModel.delegate = self
    }

    func loadMovies() {
        viewModel.loadMovies()
    }
}

extension ListViewController: ListViewModelDelegate {
    func networkState(state: NetworkState) {
        switch state {
        case .loading:
            self.tableView.backgroundView = loadingView
        case .loaded:
            print("loaded")
            self.tableView.backgroundView = nil
            self.tableView.reloadData()
        case .error:
            print("error")
            //replace with error message view
            self.tableView.backgroundView = nil
        }
    }
}
