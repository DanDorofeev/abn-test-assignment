//
//  MockLocationsService.swift
//  Places
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import Foundation

final class MockLocationsService: LocationsServiceProtocol {
      
  private(set) var getLocationsCalled = false
  var stubGetLocationsResponse: Result<LocationDTO, Error> = .failure(NSError(domain: "", code: 0))
    
  func getLocations() async throws -> LocationDTO {
    getLocationsCalled = true
    return try stubGetLocationsResponse.get()
  }
}
