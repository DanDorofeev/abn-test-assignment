//
//  AddLocationViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine
import CoreLocation

protocol AddLocationViewModelProtocol: ObservableObject {
  var formIsValid: Bool {get}
  var name: String? {get set}
  var lat: String? {get set}
  var long: String? {get set}
  
  func saveLocation()
}

final class AddLocationViewModel: AddLocationViewModelProtocol {
    
  @Published var name: String?
  @Published var lat: String?
  @Published var long: String?
  @Published private(set) var formIsValid: Bool = false
  
  private var publishers = Set<AnyCancellable>()
  
  init() {
    isLocationFormValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.formIsValid, on: self)
      .store(in: &publishers)
  }
  
  func saveLocation() {
    
  }
}

// MARK: - Private

private extension AddLocationViewModel {
  var isLocationFormValidPublisher: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest($lat, $long)
      .map { [weak self] lattitude, longitude in
        guard let longitude, !longitude.isEmpty,
              let lattitude, !lattitude.isEmpty else {return false}
        
        return self?.isLocationValid(lat: lattitude, long: longitude) ?? false
      }.eraseToAnyPublisher()
  }
    
  func isLocationValid(lat: String, long: String) -> Bool {
    guard let latitude = Double(lat), let longitude = Double(long) else {
      return false
    }
        
    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    return CLLocationCoordinate2DIsValid(coordinates)
  }
}
