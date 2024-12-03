//
//  ViewModelFactory.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation
import SwiftUI

@Observable
final class ViewModelFactory {
  private let locationsController: any LocationsControllerProtocol
  private let locationService: LocationsServiceProtocol
  private let wikiAppChecker: WikiAppCheckerProtocol
  private let deeplinkBuilder: DeeplinkBuilderProtocol
  private let locationValidator: LocationValidatorProtocol
  private let locationsRouter: LocationsRouterProtocol
  
  init(
    locationsController: any LocationsControllerProtocol,
    locationService: LocationsServiceProtocol,
    wikiAppChecker: WikiAppCheckerProtocol,
    deeplinkBuilder: DeeplinkBuilderProtocol,
    locationValidator: LocationValidatorProtocol,
    locationsRouter: LocationsRouterProtocol
  ) {
    self.locationsController = locationsController
    self.locationService = locationService
    self.wikiAppChecker = wikiAppChecker
    self.deeplinkBuilder = deeplinkBuilder
    self.locationValidator = locationValidator
    self.locationsRouter = locationsRouter
  }
  
  func makeLocationsListViewModel() -> LocationsListViewModel {
    .init(
      locationsController: locationsController,
      locationsService: locationService,
      wikiAppChecker: wikiAppChecker,
      deeplinkBuilder: deeplinkBuilder,
      locationsRouter: locationsRouter
    )
  }
  
  func makeAddLocationViewModel() -> AddLocationViewModel {
    .init(
      locationsController: locationsController,
      locationValidator: locationValidator)
  }
  
}
