//
//  AbnAPIClient.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine

protocol APIClient {
  func getLocations() -> AnyPublisher<[Location], Error>
}

final class AbnAPIClient: APIClient {
  private let dataLoader: DataLoaderProtocol
  
  // MARK: - Lifecycle
  
  init(dataLoader: DataLoaderProtocol = DataLoader()) {
    self.dataLoader = dataLoader
  }
  
  func getLocations() -> AnyPublisher<[Location], Error> {
    dataLoader.execute(
      LocationsListEndpoint.locations(),
      httpMethod: .get,
      decodingType: [Location].self,
      queue: .main,
      retries: 0)
  }
}
