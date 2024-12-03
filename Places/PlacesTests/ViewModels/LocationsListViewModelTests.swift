//
//  LocationsListViewModelTests.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 02/12/2024.
//

import XCTest
import Combine

final class LocationsListViewModelTests: XCTestCase {
  
  var sut: LocationsListViewModel!
//  var locationsController: (any LocationsControllerProtocol)?
  
  override func setUp() {
    super.setUp()
//    locationsController = LocationsController()
//    sut = LocationsListViewModel(locationsController: locationsController)
  }
  
  override func tearDown() {
    sut = nil
//    locationsController = nil
    super.tearDown()
  }
  
  func test_loadLocations() async {
    XCTAssertNil(sut.locations)
    await sut.loadLocations()
    
  }
}
