//
//  AddLocationViewModelTests.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import XCTest
import Combine

final class AddLocationViewModelTests: XCTestCase {
  var sut: AddLocationViewModel!
  var locationsController: LocationsController!
  var locationValidator: MockLocationValidator!
  
  override func setUp() {
    locationsController = LocationsController()
    locationValidator = MockLocationValidator()
    sut = AddLocationViewModel(
      locationsController: locationsController,
      locationValidator: locationValidator)
    super.setUp()
  }
  
  override func tearDown() {
    sut = nil
    locationsController = nil
    locationValidator = nil
    
    super.tearDown()
  }
  
  func test_saveLocation_whenLocationIsValid() {
    // Given
    sut.lat = "10"
    sut.long = "10"
    XCTAssertEqual(locationsController.locations, [])
    
    // When
    sut.saveLocation()
    
    // Then
    XCTAssertEqual(locationsController.locations.count, 1)
  }
  
  func test_saveLocation_whenLocationIsInvalid() {
    // Given
    sut.lat = ""
    sut.long = ""
    XCTAssertEqual(locationsController.locations, [])
    
    // When
    sut.saveLocation()
    
    // Then
    XCTAssertEqual(locationsController.locations.count, 0)
  }
}
