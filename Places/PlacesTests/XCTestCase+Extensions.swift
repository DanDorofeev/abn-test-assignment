//
//  XCTestCase + Extensions.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import XCTest

extension XCTestCase {
  func wait(
    _ condition: @escaping @autoclosure () -> (Bool),
    timeout: TimeInterval = 2) {
      wait(for: [XCTNSPredicateExpectation(
        predicate: NSPredicate(block: { _, _ in condition() }), object: nil
      )], timeout: timeout)
  }
}
