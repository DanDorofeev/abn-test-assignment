//
//  MockLocationsController.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import Foundation

final class MockLocationsController: LocationsControllerProtocol {
  var locationsPublisher: Published<[Location]>.Publisher {
    $locations
  }
  @Published private var locations: [Location]
  
  init() {
    self.locations = []
  }
  
  func addLocation(_ location: Location) {
    self.locations.append(location)
  }
  
  func addLocations(_ locations: [Location]) {
    
  }
}
