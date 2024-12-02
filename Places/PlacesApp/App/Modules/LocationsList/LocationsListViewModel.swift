//
//  LocationsListViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine

protocol LocationsListViewModelProtocol: ObservableObject {
  var locations: [Location] {get}
  var showError: Bool {get}
  var isWikiMissing: Bool {get set}
  func loadLocations() async
  func openSelectedLocation(_ location: Location)
}

final class LocationsListViewModel: LocationsListViewModelProtocol {
  
  @Published private(set) var locations: [Location]
  @Published private(set) var showError: Bool
  @Published var isWikiMissing: Bool
  
  private let locationsService: LocationsServiceProtocol
  private let locationsController: any LocationsControllerProtocol
  private let wikiAppChecker: WikiAppCheckerProtocol
  private let deeplinkBuilder: DeeplinkBuilderProtocol
  private let locationsRouter: LocationsRouterProtocol
  private var publishers: Set<AnyCancellable>
  
  init(
    locationsController: any LocationsControllerProtocol,
    locationsService: LocationsServiceProtocol = LocationsService(),
    wikiAppChecker: WikiAppCheckerProtocol = WikiAppChecker(),
    deeplinkBuilder: DeeplinkBuilderProtocol = DeeplinkBuilder(),
    locationsRouter: LocationsRouterProtocol = LocationsRouter()
  ) {
    self.locationsController = locationsController
    self.locationsService = locationsService
    self.wikiAppChecker = wikiAppChecker
    self.deeplinkBuilder = deeplinkBuilder
    self.locationsRouter = locationsRouter
    locations = .init([])
    showError = false
    isWikiMissing = false
    publishers = Set<AnyCancellable>()
        
    locationsController.locationsPublisher.sink { [weak self] in
      self?.locations = $0
    }
    .store(in: &publishers)
  }
      
  func loadLocations() async {
    Task {
      do {
        let response = try await locationsService.getLocations()
        await MainActor.run {
          self.locationsController.addLocations(response.locations)
        }
      } catch _ {        
        await MainActor.run {
          self.showError = true
        }
      }
    }
  }
  
  func openSelectedLocation(_ location: Location) {
    guard wikiAppChecker.canOpenWikiScheme() else {
      isWikiMissing = true
      return
    }
    let url = deeplinkBuilder.buildDeeplink(for: location)
    locationsRouter.openExternalUrl(url)
  }
}
