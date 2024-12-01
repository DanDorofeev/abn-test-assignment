//
//  ViewModelFactory.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation

class ViewModelFactory: ObservableObject {
  let locationsController = LocationsController()
  
  func makeLocationsListViewModel() -> LocationsListViewModel {
    .init(locationsController: locationsController)
  }
  
  func makeAddLocationViewModel() -> AddLocationViewModel {
    .init(locationsController: locationsController)
  }
  
}
