//
//  CacheTests.swift
//  TubiMoviesTests
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import XCTest
@testable import TubiMovies

class CacheTests: XCTestCase {
    var cache: DetailCache<String, String>!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cache = DetailCache(size: 3)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cache = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
    }

    func testAdd() {
        cache.add(key: "foo", val: "bar")
        XCTAssertEqual(cache.currentSize, 1)
        XCTAssertEqual(cache.get(key: "foo"), "bar")
    }

    func testIsValid() {
        cache.add(key: "foo", val: "bar")
        XCTAssertTrue(cache.isValid(key: "foo"))
    }

    func addUntilLimit() {
        cache.add(key: "foo", val: "bar")
        cache.add(key: "foo1", val: "bar1")
        cache.add(key: "foo2", val: "bar2")
        XCTAssertEqual(cache.currentSize, 3)
        XCTAssertEqual(cache.get(key: "foo"), "bar")
        XCTAssertEqual(cache.get(key: "foo1"), "bar1")
        XCTAssertEqual(cache.get(key: "foo2"), "bar2")
    }

    func addPastLimit() {
        cache.add(key: "foo", val: "bar")
        cache.add(key: "foo1", val: "bar1")
        cache.add(key: "foo2", val: "bar2")
        cache.add(key: "foo3", val: "bar3")
        XCTAssertEqual(cache.currentSize, 3)
        XCTAssertEqual(cache.get(key: "foo1"), "bar1")
        XCTAssertEqual(cache.get(key: "foo2"), "bar2")
        XCTAssertEqual(cache.get(key: "foo3"), "bar3")
    }

    func testMoveToFront() {
        cache.add(key: "foo", val: "bar")
        cache.add(key: "foo1", val: "bar1")
        cache.add(key: "foo2", val: "bar2")
        cache.add(key: "foo3", val: "bar3")
        _ = cache.get(key: "foo1")
        cache.add(key: "foo", val: "bar")
        XCTAssertEqual(cache.currentSize, 3)
        XCTAssertEqual(cache.get(key: "foo"), "bar")
        XCTAssertEqual(cache.get(key: "foo1"), "bar1")
        XCTAssertEqual(cache.get(key: "foo3"), "bar3")
    }
}
