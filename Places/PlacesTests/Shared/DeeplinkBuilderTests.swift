//
//  MockDeeplinkBuilder.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 03/12/2024.
//

import XCTest

final class DeeplinkBuilderTests: XCTestCase {
  var sut: DeeplinkBuilderProtocol!
  
  override func setUp() {
    super.setUp()
    sut = DeeplinkBuilder()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_buildDeeplink_whenGivenFullLocation_returnsWikipediaDeeplink() {
    let fullLocation = Location.fullLocation
    let deeplink = sut.buildDeeplink(for: fullLocation)
    let expectedDeeplink = URL(string: "wikipedia://namedPlace?latitude=55.7512&longitude=37.6156&locationName=LocaitonWithName")!
    XCTAssertEqual(deeplink, expectedDeeplink)
  }
  
  func test_buildDeeplink_whenGivenLocationWithoutName_returnsWikipediaDeeplink() {
    let locationWithoutName = Location.emptyNameLocation
    let deeplink = sut.buildDeeplink(for: locationWithoutName)
    let expectedDeeplink = URL(string: "wikipedia://namedPlace?latitude=55.7512&longitude=37.6156")!
    XCTAssertEqual(deeplink, expectedDeeplink)
  }
}
