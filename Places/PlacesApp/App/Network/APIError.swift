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
  case invalidURL
  case invalidHTTPStatus(Int)
  
  var localizedDescription: String {
    switch self {
    case .invalidResponse:
      return "Invalid response"
    case .invalidData:
      return "Invalid data"
    case .invalidURL:
      return "Invalid URL"
    case .invalidHTTPStatus(let status):
      return "Invalid HTTP status: \(status)"
    }
  }
}
