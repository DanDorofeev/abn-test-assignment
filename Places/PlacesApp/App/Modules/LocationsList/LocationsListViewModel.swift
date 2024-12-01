//
//  LocationsListViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine

protocol LocationsListViewModelProtocol: ObservableObject {
  var locations: [Location] {get}
  var showError: Bool {get}
  func loadLocations()
}

final class LocationsListViewModel: LocationsListViewModelProtocol {
  
  @Published private(set) var locations: [Location]
  @Published private(set) var showError: Bool
  
  private let apiClient: APIClient
  private let locationsController: any LocationsControllerProtocol
  private var publishers: Set<AnyCancellable>
  
  init(
    locationsController: any LocationsControllerProtocol,
    apiClient: APIClient = AbnAPIClient()
  ) {
    self.locationsController = locationsController
    self.apiClient = apiClient
    locations = .init([])
    showError = false
    publishers = Set<AnyCancellable>()
    
    loadLocations()
    
    locationsController.locationsPublisher.sink { [weak self] in
      self?.locations = $0
    }
    .store(in: &publishers)
  }
  
  func loadLocations() {
    apiClient.getLocations()
      .sink { [weak self] completion in
        if case .failure(let error) = completion {
            debugPrint(error.localizedDescription)
            self?.showError = true
        }
      } receiveValue: { [weak self] response in
        self?.locationsController.addLocations(response.locations)
      }
      .store(in: &publishers)
  }
}
