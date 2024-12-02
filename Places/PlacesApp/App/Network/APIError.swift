//
//  APIError.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

enum APIError: Error {
  case invalidResponse
  case invalidData
  case invalidURL(URL?)
  case unsuccessfulResponse
  case decodingError
  
  var localizedDescription: String {
    switch self {
    case .invalidResponse:
      return NSLocalizedString("api.error.invalid.response", comment: "invalid response")
    case .invalidData:
      return NSLocalizedString("api.error.invalid.data", comment: "invalid data")
    case .invalidURL(let url):
      let localizedString = NSLocalizedString("api.error.invalid.url", comment: "invalid url %@")
      if let url {
        return String(format: localizedString, url.absoluteString)
      }
      return localizedString
    case .unsuccessfulResponse:
      return NSLocalizedString("api.error.unsuccessful.response", comment: "unsuccessful response")
    case .decodingError:
      return NSLocalizedString("api.error.decoding.error", comment: "decoding error")
    }
  }
}
