//
//  MockLocationsListViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

#if DEBUG

final class MockLocationsListViewModel: LocationsListViewModelProtocol {
  var isWikiMissing: Bool = false
  
  var locations: [Location] = []
  
  var showError: Bool = false
  
  func loadLocations() {}
  
  func openSelectedLocation(_ location: Location) {}
     
}
#endif
