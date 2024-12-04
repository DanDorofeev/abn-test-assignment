//
//  MockLocationsRouter.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import Foundation

final class MockLocationsRouter: LocationsRouterProtocol {
  
  private(set) var openExternalUrlCalled: Bool = false
  
  func openExternalUrl(_ url: URL) {
    openExternalUrlCalled = true
  }
}
