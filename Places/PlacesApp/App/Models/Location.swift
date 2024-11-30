//
//  Location.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

struct Location: Decodable {
  let name: String?
  let lat: Double
  let long: Double
}
