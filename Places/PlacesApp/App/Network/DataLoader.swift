//
//  DataLoader.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Combine
import Foundation

protocol DataLoaderProtocol {
  func execute<T>(_ endpoint: Endpoint, httpMethod: HTTPMethod, decodingType: T.Type, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, Error> where T: Decodable
}

final class DataLoader: DataLoaderProtocol {
  private let session: URLSession
  private let configuration: URLSessionConfiguration
  
  init(configuration: URLSessionConfiguration = .default) {
    self.configuration = configuration
    session = URLSession(configuration: configuration)
  }
  
  func execute<T>(
  _ endpoint: Endpoint,
  httpMethod: HTTPMethod,
  decodingType: T.Type,
  queue: DispatchQueue,
  retries: Int) -> AnyPublisher<T, Error> where T: Decodable {
    
    guard let url = endpoint.url else {
        return Fail(error: APIError.invalidURL(endpoint.url)).eraseToAnyPublisher()
    }
    
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json",forHTTPHeaderField: "Accept")
    request.httpMethod = httpMethod.rawValue
    
    return URLSession.shared.dataTaskPublisher(for: request)
        .tryMap {
            guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
              throw APIError.unsuccessfulResponse
            }
            return $0.data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .receive(on: queue)
        .retry(retries)
        .eraseToAnyPublisher()
  }
}
