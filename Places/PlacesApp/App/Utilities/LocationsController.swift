//
//  LocationsController.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation

protocol LocationsControllerProtocol: ObservableObject {
  var locationsPublisher: Published<[Location]>.Publisher {get}
  
  func addLocations(_ locations: [Location])
  func addLocation(_ location: Location)
}

final class LocationsController: LocationsControllerProtocol {
  @Published private var locations: [Location] = []
  
  var locationsPublisher: Published<[Location]>.Publisher {$locations}
  
  func addLocations(_ locations: [Location]) {
    self.locations = locations
  }
  
  func addLocation(_ location: Location) {
    locations.append(location)
  }
}
