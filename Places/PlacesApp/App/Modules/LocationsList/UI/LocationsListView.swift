//
//  LocationsListView.swift
//  Places
//
//  Created by Daniil Dorofieiev on 30/11/2024.
//

import SwiftUI

struct LocationsListView<VM: LocationsListViewModelProtocol>: View {
  
  @ObservedObject var viewModel: VM
  @EnvironmentObject var viewModelFactory: ViewModelFactory
  @State var showAddLocationScreen = false
  
    var body: some View {
      NavigationStack {        
        VStack {
          locationsList()
               
          addLocationButton()
        }
        .navigationBarTitle(Text(LocalizedStringKey("locations.list.section.title")))
      }      
    }
}

// MARK: - Private

private extension LocationsListView {
  func locationsList() -> some View {
    List {
        ForEach(viewModel.locations) { location in
          LocationCell(location: location)
        }
      .headerProminence(.increased)
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
