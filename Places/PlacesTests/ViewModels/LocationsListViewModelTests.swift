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
  private let asyncWaitDuration = 0.5
    
  override func setUp() {
    super.setUp()
    let locationsController = LocationsController()
    locationsService = MockLocationsService()
    let wikiAppChecker = MockWikiAppChecker()
    let deeplinkBuilder = MockDeeplinkBuilder()
    let locationsRouter = MockLocationsRouter()
    
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
    super.tearDown()
  }
  
  func test_initialState() {
    XCTAssertEqual(sut.locations, [])
    XCTAssertFalse(sut.showError)
    XCTAssertFalse(locationsService.getLocationsCalled)
  }
  
  func test_loadLocations_noResults() async throws {
    let expectedResults: LocationDTO = .emptyResults
    let expectation = XCTestExpectation(description: "Empty results")
    locationsService.stubGetLocationsResponse = .success(expectedResults)
    let task = Task {
      await self.sut.loadLocations()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
      expectation.fulfill()
    }
    
    await fulfillment(of: [expectation], timeout: asyncWaitDuration)
    task.cancel()
    
    XCTAssertTrue(self.locationsService.getLocationsCalled)
    XCTAssertEqual(self.sut.locations, [])
    XCTAssertFalse(self.sut.showError)
  }
  
  func test_loadLocations_whenSuccess_getResults() async throws {
    // Given
    let expectedResults: LocationDTO = .testLocations
    let expectation = XCTestExpectation(description: "Locations are loaded succesfully")
    locationsService.stubGetLocationsResponse = .success(expectedResults)
    XCTAssertFalse(locationsService.getLocationsCalled)
    XCTAssertEqual(sut.locations, [])
    
    // When
    let task = Task {
      await self.sut.loadLocations()
    }
        
    DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
      expectation.fulfill()
    }
            
    await fulfillment(of: [expectation], timeout: asyncWaitDuration)
    task.cancel()
    
    // Then
    XCTAssertTrue(self.locationsService.getLocationsCalled)
    XCTAssertEqual(self.sut.locations.count, 2)
    XCTAssertEqual(self.sut.locations.first!.name, Location.fullLocation.name)
    XCTAssertEqual(self.sut.locations.last!.lat, Location.emptyNameLocation.lat)
    XCTAssertFalse(self.sut.showError)
  }
  
  func test_loadLocations_whenError_errorIsShown() async throws {
    XCTAssertFalse(sut.showError)
    locationsService.stubGetLocationsResponse = .failure(NSError(domain: "Tests", code: 1))
    let expectation = XCTestExpectation(description: "showError is set to true")
    
    let task = Task {
      await self.sut.loadLocations()
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
      expectation.fulfill()
    }
            
    await fulfillment(of: [expectation], timeout: asyncWaitDuration)
    task.cancel()
    
    XCTAssertTrue(self.locationsService.getLocationsCalled)
    XCTAssertEqual(self.sut.locations, [])
    XCTAssertTrue(self.sut.showError)
  }
}

protocol AsyncScheduler {
  static func schedule(code: @escaping () async -> Void) -> AsyncScheduler
}

protocol AsyncSchedulerFactory {
  @discardableResult
  func create(code: @escaping () async -> Void) -> AsyncScheduler
}

class AsyncSchedulerSpy: AsyncScheduler {
  var code: (() async -> Void)?
  
  init(code: @escaping () async -> Void) {
    self.code = code
  }
  
  static func schedule(code: @escaping () async -> Void) -> AsyncScheduler {
    return AsyncSchedulerSpy(code: code)
  }
  
  func execute() async {
    await code?()
  }
}

class AsyncSchedulerFactorySpy: AsyncSchedulerFactory {
  var scheduleList: [AsyncSchedulerSpy] = []
  
  @discardableResult
  func create(code: @escaping () async -> Void) -> AsyncScheduler {
    let schedule = AsyncSchedulerSpy.schedule(code: code)
    
    if let schedule = schedule as? AsyncSchedulerSpy {
        scheduleList.append(schedule)
    }
    
    return schedule
  }
  
  func executeLast() async {
    await scheduleList.popLast()?.execute()
  }
}
