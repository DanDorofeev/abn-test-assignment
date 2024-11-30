//
//  MockLocationsListViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

#if DEBUG

final class MockLocationsListViewModel: LocationsListViewModelProtocol {
  var locations: [Location] = []
  
  var showError: Bool = false
  
  func loadLocations() {}
     
}
#endif
