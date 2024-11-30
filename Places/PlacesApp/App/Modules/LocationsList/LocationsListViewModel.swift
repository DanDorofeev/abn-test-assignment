//
//  LocationsListViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine

protocol LocationsListViewModelProtocol: ObservableObject {
  var locations: [Location]? {get}
  var showError: Bool {get}
  func loadLocations()
}

final class LocationsListViewModel: LocationsListViewModelProtocol {
  
  @Published var locations: [Location]?
  @Published private(set) var showError = false
  
  private let apiClient: APIClient
  private var cancellable: AnyCancellable?
  
  init(apiClient: APIClient = AbnAPIClient()) {
      self.apiClient = apiClient
  }
  
  func loadLocations() {
    cancellable = apiClient.getLocations()
      .sink { [weak self] completion in
        if case .failure(let error) = completion {
            debugPrint(error.localizedDescription)
            self?.showError = true
        }
      } receiveValue: { [weak self] response in
        self?.locations = response.locations
      }
  }
}
