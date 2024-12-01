//
//  AddLocationViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation
import Combine

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
  @Published private(set) var formIsValid: Bool
  private let locationValidator: LocationValidatorProtocol
  private let locationsController: any LocationsControllerProtocol
  private var publishers: Set<AnyCancellable>
  
  init(
    locationsController: any LocationsControllerProtocol,
    locationValidator: LocationValidatorProtocol = LocationValidator()
  ) {
    self.locationsController = locationsController
    self.locationValidator = locationValidator
        
    formIsValid = false
    publishers = Set<AnyCancellable>()
    
    isLocationFormValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.formIsValid, on: self)
      .store(in: &publishers)
  }
  
  func saveLocation() {
    guard let lat, let long,
            let lattitude = Double(lat), let longitude = Double(long) else {return}
    let location = Location(name: name, lat: lattitude, long: longitude)
    locationsController.addLocation(location)
  }
}

// MARK: - Private

private extension AddLocationViewModel {
  var isLocationFormValidPublisher: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest($lat, $long)
      .map { [weak self] lattitude, longitude in
        guard let longitude, !longitude.isEmpty,
              let lattitude, !lattitude.isEmpty else {return false}
        
        return self?.locationValidator.isLocationValid(lat: lattitude, long: longitude) ?? false
      }.eraseToAnyPublisher()
  }      
}
