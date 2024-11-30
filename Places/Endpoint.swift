//
//  Endpoint.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

protocol Endpoint {
  var url: URL? {get}
}

struct LocationsListEndpoint: Endpoint {
  
  private let baseUrlScheme = "https"
  private let baseUrlHost = "raw.githubusercontent.com"
  
  let path: String
  
  var url: URL? {
    var components = URLComponents()
    components.scheme = baseUrlScheme
    components.host = baseUrlHost
    components.path = path
    return components.url
  }
  
  static func getLocations() -> Endpoint {
    return LocationsListEndpoint(path: "/abnamrocoesd/assignment-ios/main/locations.json")
  }
}
