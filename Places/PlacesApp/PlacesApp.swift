//
//  PlacesApp.swift
//  Places
//
//  Created by Daniil Dorofieiev on 29/11/2024.
//

import SwiftUI

@main
struct PlacesApp: App {
  var body: some Scene {
      WindowGroup {
        
        let apiClient = APIClient()
        let locationService = LocationsService(apiClient: apiClient)
        let locationsController = LocationsController()
        let wikiAppChecker = WikiAppChecker()
        let deeplinkBuilder = DeeplinkBuilder()
        let locationValidator = LocationValidator()
        let locationsRouter = LocationsRouter()
        
        let viewModelFactory = ViewModelFactory(
          locationsController: locationsController,
          locationService: locationService,
          wikiAppChecker: wikiAppChecker,
          deeplinkBuilder: deeplinkBuilder,
          locationValidator: locationValidator,
          locationsRouter: locationsRouter)
        
        LocationsListView(viewModel: viewModelFactory.makeLocationsListViewModel())
          .environment(viewModelFactory)
      }
  }
}
