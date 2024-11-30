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

struct Location: Decodable {
  let name: String?
  let lat: Double
  let long: Double
}
