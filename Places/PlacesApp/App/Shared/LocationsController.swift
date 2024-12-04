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
  
  var locationsPublisher: Published<[Location]>.Publisher {
    $locations
  }
       
  func addLocations(_ locations: [Location]) {
    self.locations.removeAll()
    self.locations = locations        
  }
  
  func addLocation(_ location: Location) {
    locations.append(location)
  }
}
