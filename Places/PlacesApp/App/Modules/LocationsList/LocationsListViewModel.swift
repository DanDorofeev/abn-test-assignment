//
//  LocationsListViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine
import UIKit

protocol LocationsListViewModelProtocol: ObservableObject {
  var locations: [Location] {get}
  var showError: Bool {get}
  var isWikiMissing: Bool {get}
  func openSelectedLocation(_ location: Location)
}

final class LocationsListViewModel: LocationsListViewModelProtocol {
  
  @Published private(set) var locations: [Location]
  @Published private(set) var showError: Bool
  @Published private(set) var isWikiMissing: Bool
  
  private let locationsService: LocationsServiceProtocol
  private let locationsController: any LocationsControllerProtocol
  private let wikiAppChecker: WikiAppCheckerProtocol
  private let deeplinkBuilder: DeeplinkBuilderProtocol
  private var publishers: Set<AnyCancellable>
  
  init(
    locationsController: any LocationsControllerProtocol,
    locationsService: LocationsServiceProtocol = LocationsService(),
    wikiAppChecker: WikiAppCheckerProtocol = WikiAppChecker(),
    deeplinkBuilder: DeeplinkBuilderProtocol = DeeplinkBuilder()
  ) {
    self.locationsController = locationsController
    self.locationsService = locationsService
    self.wikiAppChecker = wikiAppChecker
    self.deeplinkBuilder = deeplinkBuilder
    locations = .init([])
    showError = false
    isWikiMissing = false
    publishers = Set<AnyCancellable>()
        
    locationsController.locationsPublisher.sink { [weak self] in
      self?.locations = $0
    }
    .store(in: &publishers)
  }
  
  func openSelectedLocation(_ location: Location) {
    guard wikiAppChecker.isWikiAppInstalled() else {
      isWikiMissing = true
      return
    }
    let url = deeplinkBuilder.buildDeeplink(for: location)
    openExternalUrl(url)
  }
}

//MARK: - Private

private extension LocationsListViewModel {
  func openExternalUrl(_ url: URL) {
    guard UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url)
  }
}
