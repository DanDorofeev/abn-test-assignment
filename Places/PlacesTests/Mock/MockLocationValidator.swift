//
//  MockLocationValidator.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import Foundation

final class MockLocationValidator: LocationValidatorProtocol {
  
  private(set) var isLocationValidCalled = false
    
  func isLocationValid(lat: String, long: String) -> Bool {
    isLocationValidCalled = true
    return true
  }
}
