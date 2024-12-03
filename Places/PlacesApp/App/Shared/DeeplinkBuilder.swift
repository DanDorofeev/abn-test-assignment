//
//  DeeplinkBuilder.swift
//  Places
//
//  Created by Daniil Dorofieiev on 01/12/2024.
//

import Foundation

protocol DeeplinkBuilderProtocol {
  func buildDeeplink(for location: Location) -> URL
}

final class DeeplinkBuilder: DeeplinkBuilderProtocol {
  
  func buildDeeplink(for location: Location) -> URL {
    var urlComponents = URLComponents()
    urlComponents.scheme = "wikipedia"
    urlComponents.host = "namedPlace"
    urlComponents.queryItems = [
      URLQueryItem(name: "latitude", value: String(location.lat)),
      URLQueryItem(name: "longitude", value: String(location.long)),
    ]
    if let name = location.name, !name.isEmpty {
      urlComponents.queryItems?.append(
        URLQueryItem(name: "locationName", value: name)
      )
    }
    if let url = urlComponents.url {
      return url
    }
    preconditionFailure("Invalid URL")
  }
}
