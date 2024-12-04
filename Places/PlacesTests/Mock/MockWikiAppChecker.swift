//
//  MockWikiAppChecker.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 04/12/2024.
//

import Foundation

final class MockWikiAppChecker: WikiAppCheckerProtocol {
  
  private(set) var canOpenCalled = false
  
  func canOpenWikiScheme() -> Bool {
    canOpenCalled = true
    return true
  }
}
