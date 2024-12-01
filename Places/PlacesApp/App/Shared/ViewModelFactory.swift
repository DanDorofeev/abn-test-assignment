//
//  ViewModelFactory.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation

final class ViewModelFactory: ObservableObject {
  private(set) var locationsController: any LocationsControllerProtocol
  
  init(locationsController: any LocationsControllerProtocol = LocationsController()) {
    self.locationsController = locationsController
  }
  
  func makeLocationsListViewModel() -> LocationsListViewModel {
    .init(locationsController: locationsController)
  }
  
  func makeAddLocationViewModel() -> AddLocationViewModel {
    .init(locationsController: locationsController)
  }
  
}
