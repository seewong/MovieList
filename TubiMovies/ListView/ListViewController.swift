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
    let networkingService: NetworkingServiceType

    init() {
        self.viewModel = ListViewModel()
        self.networkingService = NetworkingService()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        configureViewModel()

        loadMovies()
    }

    func configureTableView() {
        ListViewCell.registerForTableView(tableView)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadMovies), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        self.refreshControl = refreshControl
        //To get rid of trailing hairlines
        tableView.tableFooterView = UIView()
    }

    func configureViewModel() {
        viewModel.delegate = self
    }

    @objc func loadMovies() {
        viewModel.loadMovies()
    }

    func navigateToDetail(id: String) {
        let detailViewController = DetailViewController(id: id, networkingService: networkingService)
        self.navigationController?.pushViewController(detailViewController, animated: true)
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
        let id = viewModel.movieList[indexPath.row].id
        navigateToDetail(id: id)
    }
}

extension ListViewController: ListViewModelDelegate {
    func networkState(state: NetworkState) {
        switch state {
        case .loading:
            self.tableView.backgroundView = loadingView
        case .loaded:
            self.tableView.backgroundView = nil
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        case .error:
            print("error")
            //replace with error message view
            self.refreshControl?.endRefreshing()
            self.tableView.backgroundView = nil
        }
    }
}
