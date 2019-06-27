//
//  ListViewModel.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/25/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public protocol ListViewModelDelegate: class {
    func networkState(state: NetworkState)
}

public class ListViewModel {
    let networkingService: NetworkingServiceType
    weak var delegate: ListViewModelDelegate?
    let disposeBag = DisposeBag()

    var movieList: [MovieListItem] = []

    //Network service can be injected for testing
    init(networkingService: NetworkingServiceType = NetworkingService()) {
        self.networkingService = networkingService
    }

    public func loadMovies() {
        self.delegate?.networkState(state: .loading)
        networkingService.getAllMovies()
            .subscribe(onNext: { [weak self] movieList in
                self?.movieList = movieList
                self?.delegate?.networkState(state: .loaded)
            }, onError: { (error) in
                print(error)
            }).disposed(by: disposeBag)
    }
}
