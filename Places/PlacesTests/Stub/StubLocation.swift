//
//  StubLocation.swift
//  PlacesTests
//
//  Created by Daniil Dorofieiev on 03/12/2024.
//

import Foundation

#if DEBUG
extension Location {
  static var fullLocation: Location {
    .init(
      name: "LocaitonWithName",
      lat: 55.7512,
      long: 37.6156)
  }
  
  static var emptyNameLocation: Location {
    .init(
      name: "",
      lat: 55.7512,
      long: 37.6156)
  }  
}
#endif
