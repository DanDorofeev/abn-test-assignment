//
//  Location.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

struct LocationDTO: Decodable {
  let locations: [Location]
}

struct Location: Decodable, Equatable, Identifiable {
  var id = UUID()
  let name: String?
  let lat: Double
  let long: Double
  
  enum CodingKeys: String, CodingKey {
    case name, lat, long
  }
}

extension Location {
  var locationName: String {
    guard let name, !name.isEmpty else {
      return "Unknown"
    }
    return name
  }
  
  var coordinatesString: String {
    "\(lat), \(long)"
  }
}
