//
//  AddLocationView.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import SwiftUI
import Combine

struct AddLocationView<VM: AddLocationViewModelProtocol>: View {
  
  @ObservedObject var viewModel: VM
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    VStack {     
        addLocationTextFields()
                
        saveLocation()
    }
  }
}

// MARK: - Private

private extension AddLocationView {
  func addLocationTextFields() -> some View {
    List {
      Section(header: Text(LocalizedStringKey("add.location.section.title"))) {
        TextField(LocalizedStringKey("add.location.name.label"),
                  text: Binding<String>(get: {viewModel.name ?? ""}, set: {viewModel.name = $0}))
        
        TextField(LocalizedStringKey("add.location.lat.label"),
                  text: Binding<String>(get: {viewModel.lat ?? ""}, set: {viewModel.lat = $0}))        
        
        TextField(LocalizedStringKey("add.location.long.label"),
                  text: Binding<String>(get: {viewModel.long ?? ""}, set: {viewModel.long = $0}))
      }
      .headerProminence(.increased)
    }
  }
    
  func saveLocation() -> some View {
    Button {
      viewModel.saveLocation()
      dismiss()
    } label: {
        Text(LocalizedStringKey("add.location.button.title"))
        .padding()
        .font(.headline)
        .foregroundColor(.button)
        .cornerRadius(Constants.CornerRadius.small)
    }
    .buttonStyle(.borderedProminent)
    .frame(maxWidth: .infinity)
    .padding()
    .disabled(!viewModel.formIsValid)
  }
}

#Preview {
  AddLocationView(viewModel: MockAddLocationViewModel())
}
