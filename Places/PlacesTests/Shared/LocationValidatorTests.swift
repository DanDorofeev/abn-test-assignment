//
//  LocationValidatorTests.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 03/12/2024.
//

import XCTest

final class LocationValidatorTests: XCTestCase {
  var sut: LocationValidatorProtocol!
  
  override func setUp() {
    super.setUp()
    sut = LocationValidator()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_isLocationValid_whenLocationIsValid_returnsTrue() {
    let actualResult = sut.isLocationValid(lat: "55.7512", long: "37.6156")
    XCTAssertTrue(actualResult)
  }
  
  func test_isLocationValid_whenLatitudeIsInvalid_returnsFalse() {
    let actualResult = sut.isLocationValid(lat: "400", long: "37.6156")
    XCTAssertFalse(actualResult)
  }
  
  func test_isLocationValid_whenLongtitudeIsInvalid_returnsFalse() {
    let actualResult = sut.isLocationValid(lat: "55.7512", long: "400")
    XCTAssertFalse(actualResult)
  }
  
  func test_isLocationValid_whenLocationIsInvalud_returnsFalse() {
    let actualResult = sut.isLocationValid(lat: "400", long: "400")
    XCTAssertFalse(actualResult)
  }  
}
