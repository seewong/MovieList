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
    func getAllMovies() -> Observable<[MovieListItem]>
}


public class NetworkingService: NetworkingServiceType {
    private let disposeBag = DisposeBag()

    public func getAllMovies() -> Observable<[MovieListItem]> {
        return Observable<[MovieListItem]>.create { (observer) -> Disposable in
            let request = Alamofire.request("https://us-central1-modern-venture-600.cloudfunctions.net/api/movies")
                .response(completionHandler: { (response) in
                    if let error = response.error {
                        observer.onError(error)
                    } else if let data = response.data, let items = JSONParser.shared.parse(data: data, type: [MovieListItem].self) {
                        observer.onNext(items)
                        observer.onCompleted()
                    }
                })
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
