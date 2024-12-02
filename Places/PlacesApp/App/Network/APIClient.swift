//
//  DataLoader.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

protocol APIClientProtocol {
  func request<T: Decodable>(_ endpoint: Endpoint, httpMethod: HTTPMethod) async throws -> T
}

final class APIClient: APIClientProtocol {
  private let session: URLSession
  private let configuration: URLSessionConfiguration
  
  init(configuration: URLSessionConfiguration = .default) {
    self.configuration = configuration
    session = URLSession(configuration: configuration)
  }
  
  func request<T: Decodable>(_ endpoint: Endpoint, httpMethod: HTTPMethod) async throws -> T {
    
    guard let url = endpoint.url else {
        throw APIError.invalidURL(endpoint.url)
    }
    
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json",forHTTPHeaderField: "Accept")
    request.httpMethod = httpMethod.rawValue
    
    let (data, response) = try await session.data(for: request)
    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 400
    
    switch statusCode {
    case 200:
      do {
        return try JSONDecoder().decode(T.self, from: data)
      } catch {
        throw APIError.decodingError
      }
    default:
      throw APIError.unsuccessfulResponse
    }
  }
}
