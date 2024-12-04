//
//  MockDeeplinkBuilder.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import Foundation

final class MockDeeplinkBuilder: DeeplinkBuilderProtocol {
  
  private(set) var buildCalled = false
  var urlString: String = ""
  
  func buildDeeplink(for location: Location) -> URL {
    buildCalled = true
    return URL(string: urlString)!
  }
}
