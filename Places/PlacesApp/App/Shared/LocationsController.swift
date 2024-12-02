//
//  LocationsController.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation
import Combine

protocol LocationsControllerProtocol: ObservableObject {
  var locationsPublisher: Published<[Location]>.Publisher {get}
  func addLocation(_ location: Location)
  func addLocations(_ locations: [Location])
}

final class LocationsController: LocationsControllerProtocol {
  @Published private var locations: [Location] = []
  private let locationsService: LocationsServiceProtocol
  
  var locationsPublisher: Published<[Location]>.Publisher {
    $locations
  }
   
  //MARK: - Lifecycle
  
  init(locationsService: LocationsServiceProtocol = LocationsService()) {
    self.locationsService = locationsService
  }
  
  func addLocations(_ locations: [Location]) {
    self.locations = locations
  }
  
  func addLocation(_ location: Location) {
    locations.append(location)
  }
}
