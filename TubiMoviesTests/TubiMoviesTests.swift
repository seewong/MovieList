//
//  TubiMoviesTests.swift
//  TubiMoviesTests
//
//  Created by Christopher Wong on 6/24/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import XCTest
@testable import TubiMovies

class TubiMoviesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
    }

    func testListPayload() {
        let payload = Data("""
            [
                {
                    "title":"Joe",
                    "image":"http://images.adrise.tv/JkC_Cw7UD2jcJtmg7dAAArPGXiE=/214x306/smart/img.adrise.tv/d57031bb-61c9-499e-bb7a-4461e76db235.jpg",
                    "id":"369854"
                },
                {
                    "title":"Man On A Ledge",
                    "image":"http://images.adrise.tv/q4v7JUQPPHqn8nTmYiudW6l8w_0=/214x306/smart/img.adrise.tv/1c31dfce-5338-4a09-bcb0-f68789153f33.png",
                    "id":"302437"
                },
                {
                    "title":"The Hunted",
                    "image":"http://images.adrise.tv/0K0omTIr4w7jyjK5I18cvW5ljWg=/214x306/smart/img.adrise.tv/c79d639a-de5f-44d4-86d9-40e5a892551e.png",
                    "id":"307852"
                },
                {
                    "title":"Igor",
                    "image":"http://images.adrise.tv/mLPoP2m45bK3Rpa92yXQL6anRf8=/214x306/smart/img.adrise.tv/a04564c2-ddd7-4d3a-bcb5-8b1b07317683.jpg",
                    "id":"334155"
                }
            ]
            """.utf8)

        let movies = JSONParser.shared.parse(data: payload, type: [Movie].self)
        XCTAssertEqual(movies?.count, 4)
        XCTAssertEqual(movies?.first?.title, "Joe")
        XCTAssertEqual(movies?.first?.imageURL, "http://images.adrise.tv/JkC_Cw7UD2jcJtmg7dAAArPGXiE=/214x306/smart/img.adrise.tv/d57031bb-61c9-499e-bb7a-4461e76db235.jpg")
        XCTAssertEqual(movies?.first?.id, "369854")
        XCTAssertEqual(movies?.first?.index, nil)
    }

    func testDetailPayload() {
        let payload = Data("""
            {
                "title":"Joe",
                "image":"http://images.adrise.tv/JkC_Cw7UD2jcJtmg7dAAArPGXiE=/214x306/smart/img.adrise.tv/d57031bb-61c9-499e-bb7a-4461e76db235.jpg",
                "id":"369854",
                "index": 0
            }
            """.utf8)

        let movie = JSONParser.shared.parse(data: payload, type: Movie.self)
        XCTAssertEqual(movie?.title, "Joe")
        XCTAssertEqual(movie?.imageURL, "http://images.adrise.tv/JkC_Cw7UD2jcJtmg7dAAArPGXiE=/214x306/smart/img.adrise.tv/d57031bb-61c9-499e-bb7a-4461e76db235.jpg")
        XCTAssertEqual(movie?.id, "369854")
        XCTAssertEqual(movie?.index, 0)
    }
}
