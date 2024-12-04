//
//  MockLocationsRouter.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import Foundation

final class MockLocationsRouter: LocationsRouterProtocol {
  
  private(set) var openExternalUrlCalled = false
  private(set) var calledUrl: URL?
  
  func openExternalUrl(_ url: URL) {
    openExternalUrlCalled = true
    calledUrl = url
  }
}
