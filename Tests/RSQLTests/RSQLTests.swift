//
//  RSQLTests.swift
//  MolgenisClientTests
//
//  Created by David van Enckevort on 09-05-18.
//

import XCTest
import RSQL

class RSQLTests: XCTestCase {

    func testTwoPredicates() throws {
        let attribute1 = "xbool"
        let attribute2 = "xint"
        let item1 = Predicate.equal(subject: attribute1, object: true)
        let item2 = Predicate.greaterOrEqualTo(subject: attribute2, object: 10)
        let and = Predicate.and(predicates: [item1, item2])
        XCTAssert(and.rsql.count > 0)
        XCTAssertEqual(and.rsql, "xbool==true;xint=ge=10")
    }
}
