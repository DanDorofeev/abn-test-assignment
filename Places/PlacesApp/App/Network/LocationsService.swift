//
//  AbnAPIClient.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine

protocol LocationsServiceProtocol {
  func getLocations() -> AnyPublisher<LocationDTO, Error>
}

final class LocationsService: LocationsServiceProtocol {
  private let dataLoader: APIClientProtocol
  
  // MARK: - Lifecycle
  
  init(dataLoader: APIClientProtocol = APIClient()) {
    self.dataLoader = dataLoader
  }
  
  func getLocations() -> AnyPublisher<LocationDTO, Error> {
    dataLoader.execute(
      LocationsListEndpoint.locations(),
      httpMethod: .get,
      decodingType: LocationDTO.self,
      queue: .main,
      retries: 0)
  }
}
