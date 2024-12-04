//
//  MockAddLocationViewModel.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import Foundation

#if DEBUG

final class MockAddLocationViewModel: AddLocationViewModelProtocol {
  var formIsValid: Bool = true
  var name: String? = ""
  var lat: String? = ""  
  var long: String? = ""
  
  func saveLocation() {}    
}
#endif
