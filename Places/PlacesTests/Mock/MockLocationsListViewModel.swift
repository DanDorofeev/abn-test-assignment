//
//  MockLocationsListViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

final class MockLocationsListViewModel: LocationsListViewModelProtocol {
  var isWikiMissing = false
  
  var locations: [Location] = []
  
  var showError = false
  
  func loadLocations() {}
  
  func openSelectedLocation(_ location: Location) {}
     
}
