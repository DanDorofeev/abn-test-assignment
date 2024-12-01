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
}

final class LocationsController: LocationsControllerProtocol {
  @Published private var locations: [Location] = []
  private let locationsService: LocationsServiceProtocol
  private var publishers: Set<AnyCancellable>
  
  var locationsPublisher: Published<[Location]>.Publisher {
    $locations
  }
   
  //MARK: - Lifecycle
  
  init(locationsService: LocationsServiceProtocol = LocationsService()) {
    self.locationsService = locationsService
    publishers = Set<AnyCancellable>()
        
    loadLocations()
  }
    
  func addLocation(_ location: Location) {
    locations.append(location)
  }
}

// MARK: - Private

private extension LocationsController {
  func loadLocations() {
    locationsService.getLocations()
      .sink { completion in
        if case .failure(let error) = completion {
            debugPrint(error.localizedDescription)
        }
      } receiveValue: { [weak self] response in
        self?.locations = response.locations
      }
      .store(in: &publishers)
  }
}

