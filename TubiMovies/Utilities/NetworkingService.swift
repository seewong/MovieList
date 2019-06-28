//
//  NetworkingService.swift
//  TubiMovies
//
//  Created by Christopher Wong on 6/25/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

public protocol NetworkingServiceType {
    func getAllMovies() -> Observable<[Movie]>
    func getMovie(id: String) -> Observable<Movie>
}


public class NetworkingService: NetworkingServiceType {
    private let disposeBag = DisposeBag()
    private let cache: DetailCache<String, Movie> = DetailCache(size: 5)

    public func getAllMovies() -> Observable<[Movie]> {
        return Observable<[Movie]>.create { (observer) -> Disposable in
            let request = Alamofire.request("https://us-central1-modern-venture-600.cloudfunctions.net/api/movies")
                .response(completionHandler: { (response) in
                    if let error = response.error {
                        observer.onError(error)
                    } else if let data = response.data, let items = JSONParser.shared.parse(data: data, type: [Movie].self) {
                        observer.onNext(items)
                        observer.onCompleted()
                    }
                })
            return Disposables.create {
                request.cancel()
            }
        }
    }

    public func getMovie(id: String) -> Observable<Movie> {
        if let movie = self.cache.get(key: id) {
            return Observable.just(movie)
        } else {
            return Observable<Movie>.create { [weak self] (observer) -> Disposable in
                let url = "https://us-central1-modern-venture-600.cloudfunctions.net/api/movies/" + id
                let request = Alamofire.request(url)
                    .response(completionHandler: { (response) in
                        if let error = response.error {
                            observer.onError(error)
                        } else if let data = response.data, let item = JSONParser.shared.parse(data: data, type: Movie.self) {
                            observer.onNext(item)
                            observer.onCompleted()

                            self?.cache.add(key: id, val: item)
                        }
                    })
                return Disposables.create {
                    request.cancel()
                }
            }
        }
    }
}
