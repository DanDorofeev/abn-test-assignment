//
//  AbnAPIClient.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine

protocol LocationsServiceProtocol {
  func getLocations() async throws -> LocationDTO
}

final class LocationsService: LocationsServiceProtocol {
  private let apiClient: APIClientProtocol
  
  // MARK: - Lifecycle
  
  init(apiClient: APIClientProtocol) {
    self.apiClient = apiClient
  }
  
  func getLocations() async throws -> LocationDTO {
    try await apiClient.request(LocationsListEndpoint.locations(), httpMethod: .get)
  }
}
