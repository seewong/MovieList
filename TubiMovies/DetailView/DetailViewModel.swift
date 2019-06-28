//
//  DetailViewModel.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import RxSwift

public protocol DetailViewModelDelegate: class {
    func networkState(state: NetworkState)
}

class DetailViewModel {
    weak var delegate: DetailViewModelDelegate?
    let id: String
    let networkingService: NetworkingServiceType
    let disposeBag = DisposeBag()
    var movie: Movie?

    init(id: String,
         networkingService: NetworkingServiceType = NetworkingService()) {
        self.id = id
        self.networkingService = networkingService
    }

    func loadMovie() {
        self.delegate?.networkState(state: .loading)
        networkingService.getMovie(id: self.id)
            .subscribe(onNext: { [weak self] movie in
                self?.movie = movie
                self?.delegate?.networkState(state: .loaded)
                }, onError: { (error) in
                    print(error)
            }).disposed(by: disposeBag)
    }
}
