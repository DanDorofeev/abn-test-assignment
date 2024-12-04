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
  var locationsService: MockLocationsService!
  var wikiAppChecker: MockWikiAppChecker!
  var locationsRouter: MockLocationsRouter!
  var deeplinkBuilder: MockDeeplinkBuilder!
    
  override func setUp() {
    super.setUp()
    let locationsController = LocationsController()
    locationsService = MockLocationsService()
    wikiAppChecker = MockWikiAppChecker()
    deeplinkBuilder = MockDeeplinkBuilder()
    locationsRouter = MockLocationsRouter()
    
    sut = LocationsListViewModel(
      locationsController: locationsController,
      locationsService: locationsService,
      wikiAppChecker: wikiAppChecker,
      deeplinkBuilder: deeplinkBuilder,
      locationsRouter: locationsRouter
    )
  }
  
  override func tearDown() {
    sut = nil
    locationsService = nil
    wikiAppChecker = nil
    locationsRouter = nil
    deeplinkBuilder = nil
    super.tearDown()
  }
  
  func test_initialState() {
    XCTAssertEqual(sut.locations, [])
    XCTAssertFalse(sut.showError)
    XCTAssertFalse(locationsService.getLocationsCalled)
  }
  
  func test_loadLocations_noResults() async throws {
    // Given
    let expectedResults: LocationDTO = .emptyResults
    locationsService.stubGetLocationsResponse = .success(expectedResults)
    
    // When
    await sut.loadLocations()
    wait(self.locationsService.getLocationsCalled)
        
    // Then
    XCTAssertTrue(locationsService.getLocationsCalled)
    XCTAssertEqual(sut.locations, [])
    XCTAssertFalse(sut.showError)
  }
  
  func test_loadLocations_whenSuccess_getResults() async throws {
    // Given
    let expectedResults: LocationDTO = .testLocations
    locationsService.stubGetLocationsResponse = .success(expectedResults)
    XCTAssertFalse(locationsService.getLocationsCalled)
    XCTAssertEqual(sut.locations, [])
    
    // When
    await sut.loadLocations()
    wait(self.locationsService.getLocationsCalled)
            
    // Then
    XCTAssertTrue(locationsService.getLocationsCalled)
    XCTAssertEqual(sut.locations.count, expectedResults.locations.count)
    XCTAssertEqual(sut.locations.first!.name, expectedResults.locations.first!.name)
    XCTAssertEqual(sut.locations.last!.lat, expectedResults.locations.last!.lat)
    XCTAssertFalse(sut.showError)
  }
  
  func test_loadLocations_whenError_showErrorIsTrue() async throws {
    // Given
    XCTAssertFalse(sut.showError)
    locationsService.stubGetLocationsResponse = .failure(NSError(domain: "Tests", code: 1))
    
    // When
    await sut.loadLocations()
    wait(self.locationsService.getLocationsCalled)
    
    // Then
    XCTAssertTrue(locationsService.getLocationsCalled)
    XCTAssertEqual(sut.locations, [])
    XCTAssertTrue(sut.showError)
  }
  
  func test_openSelectedLocation_whenWikiIsMissing_routerNotCalled() {
    // Given
    let testLocation = Location.fullLocation
    wikiAppChecker.canOpen = false
    
    // When
    sut.openSelectedLocation(testLocation)
    
    // Then
    XCTAssertTrue(wikiAppChecker.canOpenCalled)
    XCTAssertTrue(sut.isWikiMissing)
    XCTAssertFalse(locationsRouter.openExternalUrlCalled)
  }
  
  func test_openSelectedLocation_whenWikiIsInstalled_routerCalled() {
    // Given
    let testLocation = Location.fullLocation
    wikiAppChecker.canOpen = true
    deeplinkBuilder.urlString = "https://google.com"
    
    // When
    sut.openSelectedLocation(testLocation)
    
    // Then
    XCTAssertTrue(wikiAppChecker.canOpenCalled)
    XCTAssertFalse(sut.isWikiMissing)
    XCTAssertTrue(locationsRouter.openExternalUrlCalled)
  }
  
  func test_openSelectedLocation_whenWikiIsInstalled_urlIsOpened() {
    // Given
    let testLocation = Location.fullLocation
    let expectedUrl = "https://google.com"
    wikiAppChecker.canOpen = true
    deeplinkBuilder.urlString = expectedUrl
    
    // When
    sut.openSelectedLocation(testLocation)
    
    // Then
    XCTAssertEqual(locationsRouter.calledUrl, URL(string: expectedUrl))
  }
}

