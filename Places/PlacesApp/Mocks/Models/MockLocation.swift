//
//  MockLocation.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

#if DEBUG
extension Location {
  static var testLocation: Location {
    .init(name: "Test Location", lat: 55.7512, long: 37.6156)
  }
}
#endif
