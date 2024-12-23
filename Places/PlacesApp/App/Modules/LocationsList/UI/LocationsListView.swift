//
//  LocationsListView.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import SwiftUI

struct LocationsListView<VM: LocationsListViewModelProtocol>: View {
  
  @Bindable var viewModel: VM
  @Environment(ViewModelFactory.self) private var viewModelFactory
  @State var showAddLocationScreen = false
  
    var body: some View {
      NavigationStack {        
        VStack {
          if viewModel.showError {
            showErrorMessage()
          } else {
            locationsList()
            
            addLocationButton()
          }
        }
        .navigationBarTitle(Text(LocalizedStringKey("locations.list.section.title")))
      }
      .task {
        await viewModel.loadLocations()
      }
    }
}

// MARK: - Private

private extension LocationsListView {
  
  func showErrorMessage() -> some View {
    Text(LocalizedStringKey("locations.error.title"))
      .font(.headline)
      .foregroundColor(.label)
  }
  
  func locationsList() -> some View {
    List {
      ForEach(viewModel.locations) { location in
        Button {
          viewModel.openSelectedLocation(location)
        } label: {
          LocationCell(location: location)
        }
      }
      .headerProminence(.increased)
    }
    .alert(LocalizedStringKey("alert.wiki.missing.message.title"), isPresented: $viewModel.isWikiMissing) {
        Button(LocalizedStringKey("alert.button.ok"), role: .cancel) {}
    }
  }
  
  func addLocationButton() -> some View {
    Button {
      showAddLocationScreen.toggle()
    } label: {
        Text(LocalizedStringKey("locations.list.button.title"))
        .padding()
        .font(.headline)
        .foregroundColor(.button)
        .cornerRadius(Constants.CornerRadius.small)
    }
    .buttonStyle(.borderedProminent)
    .frame(maxWidth: .infinity)
    .padding()
    .navigationDestination(isPresented: $showAddLocationScreen) {
      AddLocationView(viewModel: viewModelFactory.makeAddLocationViewModel())
    }
  }
}

#Preview {
  LocationsListView(viewModel: MockLocationsListViewModel())
}
