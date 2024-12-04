//
//  MockAddLocationViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

final class MockAddLocationViewModel: AddLocationViewModelProtocol {
  var formIsValid = true
  var name: String? = ""
  var lat: String? = ""  
  var long: String? = ""
  
  func saveLocation() {}    
}
