//
//  LocationValidator.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import CoreLocation

protocol LocationValidatorProtocol {
  func isLocationValid(lat: String, long: String) -> Bool 
}

final class LocationValidator: LocationValidatorProtocol {
  func isLocationValid(lat: String, long: String) -> Bool {
    guard let latitude = Double(lat), let longitude = Double(long) else {
      return false
    }        
    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    return CLLocationCoordinate2DIsValid(coordinates)
  }
}
