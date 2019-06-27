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
        ListViewCell.registerForTableView(tableView)
        //To get rid of trailing hairlines
        tableView.tableFooterView = UIView()
    }

    func configureViewModel() {
        viewModel.delegate = self
    }

    func loadMovies() {
        viewModel.loadMovies()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listViewCell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier()) as! ListViewCell
        listViewCell.configureCell(movieListItem: viewModel.movieList[indexPath.row])
        return listViewCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
