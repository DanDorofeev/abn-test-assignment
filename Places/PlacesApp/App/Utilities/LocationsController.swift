//
//  LocationsController.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation

protocol LocationsControllerProtocol: ObservableObject {
  var locations: [Location] {get}
  
  func addLocations(_ locations: [Location])
  func addLocation(_ location: Location)
}

final class LocationsController: LocationsControllerProtocol {
  @Published private(set) var locations: [Location] = []
  
  func addLocations(_ locations: [Location]) {
    self.locations = locations
  }
  
  func addLocation(_ location: Location) {
    locations.append(location)
  }
}
