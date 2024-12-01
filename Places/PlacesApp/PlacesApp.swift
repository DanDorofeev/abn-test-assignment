//
//  PlacesApp.swift
//  Places
//
//  Created by Daniil Dorofieiev on 29/11/2024.
//

import SwiftUI

@main
struct PlacesApp: App {
  
  let viewModelFactory = ViewModelFactory()
  
  var body: some Scene {
      WindowGroup {
        LocationsListView(viewModel: viewModelFactory.makeLocationsListViewModel())
          .environmentObject(viewModelFactory)
      }
  }
}
